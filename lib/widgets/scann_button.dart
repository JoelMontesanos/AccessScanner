// ignore_for_file: avoid_print
import 'package:encrypt/encrypt.dart' as joel;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscann/provider/scan_list_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannButton extends StatelessWidget {
  const ScannButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      elevation: 10,
      child: const Icon(Icons.filter_center_focus),
      onPressed: ()async {
        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        //Uncomment the lines to use a prefabricated answer or use the QR reader, CALL THE SCANNER
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#339FFF', 'Cancelar', false, ScanMode.QR);


        //Desencriptar barcodeScanREs, RECIBED from NODE
        final decrypted = await decryptCode(barcodeScanRes);

        Map<String, dynamic> jsonData = json.decode(decrypted);
        String validez = jsonData['validez'];

        DateTime fechaValidez = DateTime.parse(validez);
        DateTime fechaActual = DateTime.now();

        if (fechaValidez.year == fechaActual.year &&
        fechaValidez.month == fechaActual.month &&
        fechaValidez.day == fechaActual.day) {
        
        // Agregar "aceptado" al string
        jsonData['validez'] = "$fechaValidez - aceptado";        
        }else{
          jsonData['validez'] = "$fechaValidez - fecha denegado";
        }
        String formattedJson = jsonData.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(',  ');
        
        String finalData = _removeQuotes(formattedJson);
        print(finalData);
        



        String jsonString = json.encode(finalData);
        // ADD to DB
        scanListProvider.nuevoScan(jsonString);
      },
    );
  }

  Future<String> decryptCode (String base64EncodedEncryptedData)async{
    // Definir la clave secreta y el IV (Initialization Vector)
    final key = joel.Key.fromUtf8('12345678901234567890123456789012'); // Clave de 32 bytes (256 bits)
    final iv = joel.IV.fromUtf8('abcdefghijklmnop'); // IV de 16 bytes

    // Decodificar el valor cifrado en base64 a bytes
    //final encryptedData = base64.decode(base64EncodedEncryptedData);

    // Crear un objeto Encrypter utilizando el algoritmo AES en modo CBC y con relleno PKCS7
    final encrypter = joel.Encrypter(joel.AES(key, mode: joel.AESMode.cbc, padding: 'PKCS7'));

    try {
    // Descifrar los datos utilizando la clave y el IV
    final decrypted = encrypter.decrypt64(base64EncodedEncryptedData, iv: iv);

    //print(decrypted); // Imprimir los datos descifrados

    return decrypted;

  }catch(e) {
    print('Error al desencriptar: $e');
    return ''; // Manejar el error según tus necesidades
  }
}

String _removeQuotes(String value) {
  if (value.startsWith('"') && value.endsWith('"')) {
  
    return value.substring(1, value.length - 1);
  }
  return value;
}

}
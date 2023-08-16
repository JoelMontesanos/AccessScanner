// ignore_for_file: avoid_print
import 'package:encrypt/encrypt.dart' as joel;
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
        /*String valor = 'Joel Montesanos casa 24 LK98302PL March Blanco aceptado';
        final joel.Encrypted encrypt = encryptCode(valor);
        print(encrypt.base64);

        final String decrypted = decryptCode(encrypt);
        print(decrypted);*/


        
        //Uncomment the lines to use a prefabricated answer or use the QR reader
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#339FFF', 'Cancelar', false, ScanMode.QR);
        String barcodeScanRes= 'Joel Montesanos casa 24 LK98302PL March Blanco denegado';
        final joel.Encrypted encrypt = encryptCode(barcodeScanRes);
        final String decrypted = decryptCode(encrypt);

        //scanListProvider.nuevoScan('Joel Montesanos casa 24 LK98302PL March Blanco aceptado');
        scanListProvider.nuevoScan(decrypted);
      },
    );
  }

  encryptCode(valor){
    final key = joel.Key.fromLength(32);
    final iv = joel.IV.fromLength(8);
    final encrypter = joel.Encrypter(joel.Salsa20(key));

    final encrypted = encrypter.encrypt(valor, iv: iv);
    return encrypted;//it works
  }
  decryptCode(encrypted){
    final key = joel.Key.fromLength(32);
    final iv = joel.IV.fromLength(8);
    final encrypter = joel.Encrypter(joel.Salsa20(key));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;// it works
  }


}
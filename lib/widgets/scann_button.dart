// ignore_for_file: avoid_print

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
        //Uncomment the lines to use a prefabricated answer or use the QR reader
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#339FFF', 'Cancelar', false, ScanMode.QR);
        //String barcodeScanRes= 'http://google.com!!';
        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        //scanListProvider.nuevoScan('Joel Montesanos casa 24 LK98302PL March Blanco aceptado');
        scanListProvider.nuevoScan(barcodeScanRes);
      },
    );
  }
}
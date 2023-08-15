import 'package:flutter/material.dart';
import 'package:qrscann/widgets/scan_tiles.dart';


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const ScanTiles(tipo: 'denegado');
  }
}
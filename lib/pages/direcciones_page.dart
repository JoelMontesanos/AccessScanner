import 'package:flutter/material.dart';
import 'package:qrscann/widgets/scan_tiles.dart';


class DireccionesPage extends StatelessWidget {
  const DireccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'aceptado');
}
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/scan_list_provider.dart'; 

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({super.key, required this.tipo});
  

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;


    return  ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_,i) =>ListTile(
          leading: Icon(
            tipo =='aceptado' 
            ? Icons.check
            : Icons.back_hand_rounded, color: Colors.green, size: 35,),
          title: Text(scans[i].valor),
          subtitle:Text(scans[i].id.toString()),
          //trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.grey,),
          //onTap: ()=> print(scans[i].id),
        ),
      );
  }
}


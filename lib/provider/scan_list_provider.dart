import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrscann/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'aceptado';

  nuevoScan(String valor )async{
    final nuevoScan = ScanModel(valor:valor);
    final id = await DBProvider.db.nuevoScann(nuevoScan);
    //asignar el ID de la base de datos al modelo
    nuevoScan.id = id;
    scans.add(nuevoScan);
    if(tipoSeleccionado == nuevoScan.tipo){
      scans.add(nuevoScan);
      notifyListeners();
    }
  }
  cargarScans()async{
    final scans =await DBProvider.db.getThemAll();
    this.scans = [...scans!];
    notifyListeners();
  }
  cargarScansPorTipo(String tipo)async{
    final scans = await DBProvider.db.getThemByType(tipo);
    this.scans = [...scans!];
    tipoSeleccionado = tipo;
    notifyListeners();

  }
  borrarTodos()async{
    await DBProvider.db.deleteThemAll();
    scans = [];
    notifyListeners();
  }
  borrarScansPorId(int id)async{
    await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }


}
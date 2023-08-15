import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscann/models/scan_model.dart';
export 'package:qrscann/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null ) return _database;
    _database = await initDB();
    return _database;
  }


  Future<Database> initDB() async {
  // path donde se almacena la base de datos
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'ScansDB.db');
  //print(path);

  // Crea la base de datos
  return await openDatabase(
    path,
    version: 2,
    onOpen: (db){},
    onCreate: (Database db, int version)async{
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    }
    );
}
//Crear un nuevo Scan Raw
/*Future <int>nuevoScannRaw(ScanModel nuevoScan)async{
final db = await database;
final id = nuevoScan.id;
final tipo = nuevoScan.tipo;
final valor = nuevoScan.valor;

final res = await db!.rawInsert('''
  INSERT INTO Scans(id, tipo, valor) VALUES ('$id','$tipo', '$valor')
''');
return res;
}*/

//Crear un nuevo Scan
Future <int>nuevoScann(ScanModel nuevoScan)async{
  final db = await database;
  final res = await db!.insert('Scans', nuevoScan.toJson());
  // ID del último registro
  return res;
}
Future<ScanModel?>getScanById(int id)async{
  final db = await database;
  final res = await db!.query('Scans', where: 'id=?', whereArgs: [id]);
  return res.isNotEmpty
  ? ScanModel.fromJson(res.first)
  : null;
} 

Future<List<ScanModel>?>getThemAll()async{
  final db = await database;
  final res = await db!.query('Scans');
  return res.isNotEmpty
  ? res.map( (s)=>ScanModel.fromJson(s) ).toList()
  : [];
} 
Future<List<ScanModel>?>getThemByType(String tipo)async{
  final db = await database;
  final res = await db!.query('Scans', where: 'tipo=?',whereArgs: [tipo]);
  //final res = await db!.rawQuery('''SELECT * FROM Scans WHERE tipo = '$tipo ''');//hay un error en scan list provider a la hora de aceptar 'geo', de sintaxis
  return res.isNotEmpty
  ? res.map( (s)=>ScanModel.fromJson(s) ).toList()
  : [];
} 

Future<int> updateScan (ScanModel nuevoScan) async{
  final db = await database;
  final res = await db!.update('Scans', nuevoScan.toJson(), where: 'id=?', whereArgs: [nuevoScan.id]);
  return res;
}

Future <int> deleteScan (int id)async{
  final db = await database;
  final res = await db!.delete('Scans', where: 'id=?', whereArgs: [id]);
  return res;
}
Future <int> deleteThemAll ()async{
  final db = await database;
  final res = await db!.delete('Scans');
  return res;
}
}
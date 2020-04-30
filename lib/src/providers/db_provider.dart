import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:smart_home_sql/src/models/device_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'DevicesDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Devices ('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'ip TEXT,'
          'port TEXT,'
          'password TEXT'
          ')');
    });
  }

  //Crear registros
  newDevice( DeviceModel device) async {
    final db = await database;
    final res = db.insert('Devices', device.toJson());
    return res;
  }

  //Leer Registros
  Future<List<DeviceModel>> getAllDevices() async {
    final db = await database;
    final res = await db.query('Devices');
    List<DeviceModel> list = res.isNotEmpty ? res.map((c) => DeviceModel.fromJson(c)).toList() : [];
    return list;
  }

  //leer un Registro
  Future<DeviceModel> getDevice(int id) async {
    final db = await database;
    final res = await db.query('Devices', where: 'id = ?', whereArgs: [id]);
    print("Gotthem");
    return res.isNotEmpty ? DeviceModel.fromJson(res.first) : null;
  }


  //Actualizar
  Future<int> updateDevice(DeviceModel device) async {
    final db = await database;
    final res = await db.update('Devices', device.toJson(), where: 'id = ?', whereArgs: [device.id] );
    return res;
  }

  //Eliminar
  Future<int> deleteDevice(int id) async { 
    final db = await database;
    final res = await db.delete('Devices', where: 'id = ?', whereArgs: [id]);
    return res;
  } 

}


import 'dart:async';
import 'package:smart_home_sql/src/models/device_model.dart';
import 'package:smart_home_sql/src/providers/db_provider.dart';

class DeviceBloc {
  
  static final DeviceBloc _singleton = new DeviceBloc._internal();
  
  factory DeviceBloc(){
    return _singleton;
  }

  DeviceBloc._internal(){
    obtenerDevices();
  }

  final _deviceController = StreamController<List<DeviceModel>>.broadcast();

  Stream<List<DeviceModel>> get deviceStream => _deviceController.stream;

  dispose(){
    _deviceController.close();
  }

  obtenerDevices() async {
    _deviceController.sink.add(await DBProvider.db.getAllDevices());
  }

  obtenerDevice(int id) async {
    return await DBProvider.db.getDevice(id);
  }

  agregarDevices(DeviceModel device) async {
    await DBProvider.db.newDevice(device);
    obtenerDevices();
  }

  editarDevices(DeviceModel device) async {
    await DBProvider.db.updateDevice(device);
    obtenerDevices();
  }

  borrarDevices(int id) async {
    await DBProvider.db.deleteDevice(id);
    obtenerDevices();
  }


}
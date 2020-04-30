import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/models/device_model.dart';
import 'package:smart_home_sql/src/pages/home_page.dart';
import 'package:smart_home_sql/src/shared/pop_up.dart';

class DevicesAvailable extends StatelessWidget {
  final mainTittleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 50.0);
  final tileTittleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 30.0);
  final tilesubFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 20.0);
  final List<dynamic> devices;
  int port;
  final deviceBloc = DeviceBloc();
  DevicesAvailable({this.devices, this.port});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Devices Available",
          style: titleFont,
        ),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(devices[index].toString(), style: tileTittleFont),
                subtitle: Text(
                  port.toString(),
                  style: tilesubFont,
                ),
                leading: Icon(Icons.devices_other),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final device = DeviceModel(
                      name: "New Device",
                      ip: devices[index],
                      port: port.toString(),
                      password: "");
                  deviceBloc.agregarDevices(device);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

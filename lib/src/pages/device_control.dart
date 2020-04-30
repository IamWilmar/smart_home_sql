import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/shared/pop_up.dart';
import 'package:smart_home_sql/src/shared_prefs/preferencias_usuario.dart';

class DeviceControl extends StatefulWidget {
  static final String routeName = 'control';
  final Socket sock;
  DeviceControl({this.sock});

  @override
  _DeviceControlState createState() => _DeviceControlState(sock);
}

class _DeviceControlState extends State<DeviceControl> {
  Socket sock;
  _DeviceControlState(this.sock);

  final DeviceBloc deviceBloc = DeviceBloc();

  final TextStyle titleFont = TextStyle(
      fontSize: 30.0, fontWeight: FontWeight.w100, color: Colors.black);

  String message = "";

  bool isConnected = false;

  @override
  void dispose() {
    sock.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final prefs = PreferenciasUsuario();
    return FutureBuilder<dynamic>(
        future: deviceBloc.obtenerDevice(prefs.actualIndex),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          if(sock.port == null){
            isConnected = false;
          }else{
            isConnected = true;
          }
          print(isConnected.toString());
          final dev = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text("Second Page", style: titleFont),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    prefs.actualPage = DeviceControl.routeName;
                    prefs.actualName = dev.name;
                    prefs.actualIp = dev.ip;
                    prefs.actualPort = dev.port;
                    settingsPopUp(context);
                  },
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                TextField(
                  onChanged: (val) {
                    setState(() {
                      message = val;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Send"),
                  onPressed: () {
                    sock.write('$message\n');
                  },
                ),
                Switch(
                  onChanged: (state) {

                  },
                  value: false,
                ),
                Center(child: Text(sock.port.toString(), style: titleFont, )),
                Center(child: Text(prefs.actualName, style: titleFont)),
              ],
            ),
          );
        });
  }

}

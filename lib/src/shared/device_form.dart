import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/models/device_model.dart';
import 'package:smart_home_sql/src/pages/device_control.dart';
import 'package:smart_home_sql/src/pages/home_page.dart';
import 'package:smart_home_sql/src/shared_prefs/preferencias_usuario.dart';
import 'package:smart_home_sql/src/utils/utils.dart' as utils;

class DeviceForm extends StatefulWidget {
  @override
  _DeviceFormState createState() => _DeviceFormState();
}

class _DeviceFormState extends State<DeviceForm> {
  final devicesBloc = new DeviceBloc();

  PreferenciasUsuario prefs = PreferenciasUsuario();

  final formKey = GlobalKey<FormState>();

  final titleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 15.0);

  final buttonFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 10.0);

  String _name;
  String _ip;
  String _port;

  String _initName;
  String _initIp;
  String _initPort;
  DeviceModel device;

  void firstAsign() {
    if (prefs.actualPage == HomePage.routeName) {
      _initName = "";
      _initIp = "";
      _initPort = "";
    } else if (prefs.actualPage == DeviceControl.routeName) {
      _initName = prefs.actualName;
      _initIp = prefs.actualIp;
      _initPort = prefs.actualPort;
      print("$_initName - $_initIp - $_initPort");
    }
  }

  @override
  Widget build(BuildContext context) {
    firstAsign();
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _crearNombre(),
            _crearIp(),
            _crearPuerto(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _crearBoton(),
                _crearCancelBoton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: _initName,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Name",
        labelStyle: titleFont,
        hintText: "Kitchen light",
      ),
      onSaved: (value) => _name = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Between 3 or 6 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearIp() {
    return TextFormField(
      initialValue: _initIp,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Ip",
        labelStyle: titleFont,
        hintText: "192.168.1.1",
      ),
      onSaved: (value) => _ip = value,
      validator: (value) {
        if (value != "") {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearPuerto() {
    return TextFormField(
      initialValue: _initPort,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Port",
        labelStyle: titleFont,
      ),
      onSaved: (value) => _port = value,
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print('$_name');
    print('$_ip');
    print('$_port');

    if (prefs.actualPage == HomePage.routeName) {
      final device =
          DeviceModel(name: _name, ip: _ip, port: _port, password: "");
      devicesBloc.agregarDevices(device);
      print("Agregado");
      Navigator.pop(context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (prefs.actualPage == DeviceControl.routeName) {
      int id = prefs.actualIndex;
      final device =
          DeviceModel(id: id, name: _name, ip: _ip, port: _port, password: "");
      devicesBloc.editarDevices(device);
      print("Editado");
      Navigator.pop(context);
    }
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: Icon(
        Icons.check,
      ),
      label: Text("Save changes", style: buttonFont),
      onPressed: _submit,
    );
  }

  Widget _crearCancelBoton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: Icon(
        Icons.clear,
      ),
      label: Text("Cancel", style: buttonFont),
      onPressed: () => Navigator.pop(context),
    );
  }
}

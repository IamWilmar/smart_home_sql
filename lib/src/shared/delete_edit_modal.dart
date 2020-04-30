import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/models/device_model.dart';

class DeleteEditMenu extends StatelessWidget {
  final DeviceModel device;
  DeleteEditMenu({this.device});
  final TextStyle fontStyle =
      TextStyle(fontWeight: FontWeight.w100, fontSize: 30.0);
  final deviceBloc = DeviceBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        color: Colors.white,
      ),
      height: 100,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text("Options", style: fontStyle),
          SizedBox(height: 10.0),
          _deleteButton(context, Icons.delete_outline, 'Delete Device'),
        ],
      ),
    );
  }

  Widget _deleteButton(BuildContext context, IconData icon, String label) {
    return FlatButton.icon(
      icon: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
      label: Text(label, style: fontStyle, textAlign: TextAlign.left),
      onPressed: () {
        deviceBloc.borrarDevices(device.id);
        Navigator.pop(context);
      },
    );
  }

}

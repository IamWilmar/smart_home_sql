import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/models/device_model.dart';

class ListDevices extends StatelessWidget {

  final deviceBloc = DeviceBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DeviceModel>>(
      stream: deviceBloc.deviceStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<DeviceModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final devices = snapshot.data;
        if (devices.length == 0) {
          return Center(
            child: Text("No devices yet"),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: devices.length,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal:20.0, vertical:10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {},
                title: Text(devices[i].name),
              ),
            );
          },
        );
      },
    );
  }
}

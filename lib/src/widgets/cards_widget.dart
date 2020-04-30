import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/models/device_model.dart';
import 'package:smart_home_sql/src/pages/device_control.dart';
import 'package:smart_home_sql/src/pages/home_page.dart';
import 'package:smart_home_sql/src/pages/loading_page.dart';
import 'package:smart_home_sql/src/shared/delete_edit_modal.dart';
import 'package:smart_home_sql/src/shared_prefs/preferencias_usuario.dart';

class CardsDevices extends StatelessWidget {
  final deviceBloc = DeviceBloc();
  final titleText = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w100,
  );
  final ipText = TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100);
  final portText = TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100);
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Center(child: Text("Nothing yet :c", style: titleText)),
              ],
            ),
          );
        }

        return Swiper(
          layout: SwiperLayout.STACK,
          itemCount: devices.length,
          itemWidth: _screenSize.width * 0.6,
          itemHeight: _screenSize.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            return _cardContent(context, devices, index);
          },
        );
      },
    );
  }

  Widget _cardContent(
      BuildContext context, List<DeviceModel> devices, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: () {
          prefs.actualIndex = devices[index].id;
          prefs.actualIp    = devices[index].ip;
          prefs.actualName  = devices[index].name;
          prefs.actualPort  = devices[index].port;
          _deviceBound(context, devices[index]);
        },
        onLongPress: () => _deleteEditModal(context, devices[index]),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10.0,
              runAlignment: WrapAlignment.start,
              runSpacing: 10.0,
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  devices[index].name,
                  style: titleText,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(devices[index].ip,
                    style: ipText, textAlign: TextAlign.left),
                Text(devices[index].port,
                    style: portText, textAlign: TextAlign.left),
                Text(
                  devices[index].id.toString(),
                  style: portText,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteEditModal(BuildContext context, DeviceModel device) {
    showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(),
      ),
      context: context,
      builder: (context) {
        return DeleteEditMenu(device: device);
      },
    );
  }

  void _deviceBound(BuildContext context, DeviceModel device) async {
    String ip = device.ip;
    int port = int.parse(device.port);
    Navigator.pushNamed(context, LoadingPage.routeName);
    try {
      await Socket.connect(ip, port).then((c) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DeviceControl(sock: c)));
      });
    } catch (e) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }
}

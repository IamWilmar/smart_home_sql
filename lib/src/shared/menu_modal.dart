import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/pages/device_connected_page.dart';
import 'package:wifi/wifi.dart';
import 'package:http/http.dart' as http;
import 'package:ping_discover_network/ping_discover_network.dart';

class MenuSettings extends StatefulWidget {
  @override
  _MenuSettingsState createState() => _MenuSettingsState();
}

class _MenuSettingsState extends State<MenuSettings> {
  TextStyle fontStyle = TextStyle(fontWeight: FontWeight.w100, fontSize: 30.0);
  TextStyle subStyle = TextStyle(fontWeight: FontWeight.w100, fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        color: Colors.white,
      ),
      height: 200,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text("Menu", style: fontStyle),
          SizedBox(height: 10.0),
          FlatButton.icon(
            icon: Icon(
              Icons.device_hub,
              color: Theme.of(context).primaryColor,
            ),
            label: Text(
              "Find devices",
              style: subStyle,
            ),
            onPressed: () {
              _findDevices();
            },
          ),
        ],
      ),
    );
  }

  void _findDevices() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 1234;
    final List device = [];
    final stream = NetworkAnalyzer.discover2(subnet, port);
    http.Client client = http.Client();
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        device.add(addr.ip);
        print('Found device: ${addr.ip} - ${addr.exists}');
              Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DevicesAvailable(devices: device, port: port)));
      }
    });
  }
}

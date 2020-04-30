import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/shared/device_form.dart';

final titleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 20.0);

settingsPopUp(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return ListView(
          children: <Widget>[
            SizedBox(height: 100.0),
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text("Settings", style: titleFont),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DeviceForm(),
                ],
              ),
            ),
          ],
        );
      });
}

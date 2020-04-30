import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/bloc/devices_bloc.dart';
import 'package:smart_home_sql/src/shared/menu_modal.dart';
import 'package:smart_home_sql/src/shared_prefs/preferencias_usuario.dart';
import 'package:smart_home_sql/src/widgets/cards_widget.dart';
import 'package:smart_home_sql/src/shared/pop_up.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final mainTittleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 50.0);
  final titleFont = TextStyle(fontWeight: FontWeight.w100, fontSize: 20.0);
  final deviceBloc = DeviceBloc();
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    deviceBloc.obtenerDevices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Expanded(child: _upperBar(context)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _decoration(context),
          ListView(
            children: <Widget>[
              _nameBar(),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CardsDevices(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _upperBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          color: Theme.of(context).primaryColor,
          onPressed: () => _menuModal(context),
          iconSize: 30.0,
        ),
        IconButton(
          icon: Icon(Icons.add_to_queue),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            prefs.actualPage = HomePage.routeName;
            settingsPopUp(context);
          },
          iconSize: 30.0,
        ),
      ],
    );
  }

  void _menuModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(),
      ),
      context: context,
      builder: (context) {
        return MenuSettings();
      },
    );
  }

  Widget _nameBar() {
    return Row(
      children: <Widget>[
        Text('Devices', style: mainTittleFont),
      ],
    );
  }

  Widget _decoration(BuildContext context) {
    return Positioned(
      top: 400,
      left: -50,
      child: Transform.rotate(
        angle: -pi / 5,
        child: Container(
          height: 340.0,
          width: 340.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

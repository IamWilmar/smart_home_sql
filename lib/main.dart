import 'package:flutter/material.dart';
import 'package:smart_home_sql/src/pages/device_control.dart';
import 'package:smart_home_sql/src/pages/home_page.dart';
import 'package:smart_home_sql/src/pages/loading_page.dart';
import 'package:smart_home_sql/src/shared_prefs/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navi',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName      : (BuildContext context) => HomePage(),
        DeviceControl.routeName : (BuildContext context) => DeviceControl(),
        LoadingPage.routeName   : (BuildContext context) => LoadingPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.green[900],
        secondaryHeaderColor: Colors.black,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
      ),
    );
  }
}

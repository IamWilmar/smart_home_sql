import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_sql/src/pages/home_page.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get actualPage {
    return _prefs.getString('actualPage') ?? HomePage.routeName;
  }

  set actualPage(String routeName) {
    _prefs.setString('actualPage', routeName);
    print(routeName);
  }

  get actualIndex {
    return _prefs.getInt('id') ?? 1;
  }

  set actualIndex(int id) {
    _prefs.setInt('id', id);
    print(id);
  }

  get actualName {
    return _prefs.getString('actualName');
  }

  set actualName(String name) {
    _prefs.setString('actualName', name);
  }

  get actualIp {
    return _prefs.getString('actualIp');
  }

  set actualIp(String ip) {
    _prefs.setString('actualIp', ip);
  }

    get actualPort {
    return _prefs.getString('actualPort');
  }

  set actualPort(String port) {
    _prefs.setString('actualPort', port);
  }

}

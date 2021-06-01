import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences _sharedPref;
  init() async {
    if (_sharedPref == null) {
      _sharedPref = await SharedPreferences.getInstance();
    }
  }
  String get tokentemp => _sharedPref.getString('token')??'';
  String get uuidtemp => _sharedPref.getString('uuid')??'';
  String get login => _sharedPref.getString('logged')??"";
}

final sharedPrefs = SharedPref();

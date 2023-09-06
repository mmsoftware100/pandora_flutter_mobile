import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider extends ChangeNotifier{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userName ="";
  String password ="";


  saveUserNameAndPassword(String userName, String password) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('username', userName);
    prefs.setString('password', password);
    getSahredPreferenesData();
    notifyListeners();

  }
   getSahredPreferenesData() async {
    final SharedPreferences prefs = await _prefs;

      userName = (prefs.getString('username') ?? "");
      password = (prefs.getString('password') ?? "");
      notifyListeners();

    print("userName is "+userName!);
  }
}
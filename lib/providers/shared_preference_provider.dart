import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider extends ChangeNotifier{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userName ="";
  String password ="";


  saveUserNameAndPassword(String userNameUpdate, String passwordUpdate) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('username', userNameUpdate);
    prefs.setString('password', passwordUpdate);
    // getSahredPreferenesData();
    userName = userNameUpdate;
    password = passwordUpdate;

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
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider extends ChangeNotifier{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userName ="";
  String password ="";
  bool termsAndConditionAgree = false;


  saveUserNameAndPassword(String userNameUpdate, String passwordUpdate) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('username', userNameUpdate);
    prefs.setString('password', passwordUpdate);
     getSahredPreferenesData();
    userName = userNameUpdate;
    password = passwordUpdate;

    notifyListeners();

  }
   getSahredPreferenesData() async {
    final SharedPreferences prefs = await _prefs;

      userName = (prefs.getString('username') ?? "");
      password = (prefs.getString('password') ?? "");
      termsAndConditionAgree = (prefs.getBool('termsAndConditonAgreement') ?? false);
      notifyListeners();

    print("userName is "+userName!);
  }

  saveTermsAndConditionAgreement()async{
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('termsAndConditonAgreement', true);
    getSahredPreferenesData();
    termsAndConditionAgree = true;
    notifyListeners();
  }
}
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesInterfaceImpl extends PreferencesInterface {

  SharedPreferences _prefs;
  @override
  Future initPreferences() async => _prefs = await SharedPreferences.getInstance();

  @override
  void setDefaultUsername(String username) => _prefs.setString(default_username, username);

  @override
  String get defaultUsername => _prefs.getString(default_username);
}
import 'dart:async';

abstract class PreferencesInterface{
//Preferences
  final DEFAULT_USERNAME = "DEFAULT_USERNAME";

  Future initPreferences();
  String get defaultUsername;
  void setDefaultUsername(String username);
}
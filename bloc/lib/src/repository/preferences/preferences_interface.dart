import 'dart:async';

abstract class PreferencesInterface{

  @protected
  final DEFAULT_USERNAME = "DEFAULT_USERNAME";

  Future initPreferences();
  String get defaultUsername;
  void setDefaultUsername(String username);
}
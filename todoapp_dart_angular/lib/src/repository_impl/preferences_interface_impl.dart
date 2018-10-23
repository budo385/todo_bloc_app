import 'dart:async';
import 'dart:html';
import 'package:bloc/bloc.dart';

class PreferencesInterfaceImpl extends PreferencesInterface {

  Storage storage = window.localStorage;

  @override
  Future initPreferences() async {
    return null;
  }

  @override
  String get defaultUsername => storage[DEFAULT_USERNAME];

  @override
  void setDefaultUsername(String username) {
    storage[DEFAULT_USERNAME] = username;
  }
}
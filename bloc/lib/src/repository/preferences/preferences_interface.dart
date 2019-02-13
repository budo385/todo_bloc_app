import 'dart:async';
import 'package:meta/meta.dart';

abstract class PreferencesInterface{

  @protected
  final default_username = "DEFAULT_USERNAME";

  Future initPreferences();
  String get defaultUsername;
  void setDefaultUsername(String username);
}
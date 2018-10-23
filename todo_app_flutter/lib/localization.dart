import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      "appName": "ToDo App",
      "ok": "OK",
      "cancel": "Cancel",
      "errorTitle": "Error",
      //Login
      "login": "Sign In",
      "username": "Username",
      "password": "Password",
      "usernameEmpty": "Username must not be empty!",
      "passwordEmpty": "Password must not be empty!",
      //Todolist
      "todoList": "Todo list",
      "created": "Created:",
      "ended": "Ended:",
      //Tododetail
      "todo": "Todo",
      "title": "Title",
      "description": "Description",
      "titleEmpty": "Title must not be empty!",
      "descriptionEmpty": "Description must not be empty!",
      //Sign out
      "signoutTitle": "Sign out",
      "signoutDescr": "Do you want to sign out?",
    },
  };

  String get appName => localizedValues[locale.languageCode]['appName'];
  String get ok => localizedValues[locale.languageCode]['ok'];
  String get cancel => localizedValues[locale.languageCode]['cancel'];
  String get errorTitle => localizedValues[locale.languageCode]['errorTitle'];
  String get login => localizedValues[locale.languageCode]['login'];
  String get username => localizedValues[locale.languageCode]['username'];
  String get password => localizedValues[locale.languageCode]['password'];
  String get usernameEmpty => localizedValues[locale.languageCode]['usernameEmpty'];
  String get passwordEmpty => localizedValues[locale.languageCode]['passwordEmpty'];
  String get todoList => localizedValues[locale.languageCode]['todoList'];
  String get created => localizedValues[locale.languageCode]['created'];
  String get ended => localizedValues[locale.languageCode]['ended'];
  String get todo => localizedValues[locale.languageCode]['todo'];
  String get title => localizedValues[locale.languageCode]['title'];
  String get description => localizedValues[locale.languageCode]['description'];
  String get titleEmpty => localizedValues[locale.languageCode]['titleEmpty'];
  String get descriptionEmpty => localizedValues[locale.languageCode]['descriptionEmpty'];
  String get signoutTitle => localizedValues[locale.languageCode]['signoutTitle'];
  String get signoutDescr => localizedValues[locale.languageCode]['signoutDescr'];
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of Localization.
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
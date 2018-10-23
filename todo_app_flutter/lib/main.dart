import 'package:flutter/material.dart';
import 'package:todo_app_flutter/di/inject.dart';
import 'package:todo_app_flutter/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app_flutter/ui/login/login.dart';
import 'package:todo_app_flutter/ui/todo_list/todo_list.dart';

void main() async {

  await Injection.initInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        primaryColor: Colors.teal.shade700,
        primaryColorLight: Colors.tealAccent.shade700,
        primaryColorDark: Colors.teal.shade900,
        buttonColor: Colors.teal.shade200,
        accentColor: Colors.pink.shade500,
      ),
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/todos': (context) => TodoList(),
      },
    );
  }
}
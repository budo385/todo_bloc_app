import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:todo_app_flutter/bloc_impl/session_impl.dart';
import 'package:todo_app_flutter/repository_impl/preferences_interface_impl.dart';
import 'package:todo_app_flutter/repository_impl/todo_repository_impl.dart';

class Injection {

  static Firestore _firestore = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static PreferencesInterface _preferencesInterface = PreferencesInterfaceImpl();

  static Injector injector;
  static Future initInjection() async {
    await _preferencesInterface.initPreferences();
    injector = Injector.getInjector();
    //Session
    injector.map<Session>((i) => SessionImpl(_auth, _firestore), isSingleton: true);
    //Repository
    injector.map<ToDoRepository>((i) => ToDoRepositoryImpl(injector.get<Session>()), isSingleton: false);
    //Bloc
    injector.map<LoginBloc>((i) => LoginBloc(_preferencesInterface, injector.get<Session>()), isSingleton: false);
    injector.map<TodoListBloc>((i) => TodoListBloc(injector.get<ToDoRepository>(), injector.get<Session>()), isSingleton: false);
    injector.map<TodoAddEditBloc>((i) => TodoAddEditBloc(injector.get<ToDoRepository>()), isSingleton: false);
  }
}


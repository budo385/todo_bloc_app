import 'package:angular/angular.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:todoapp/app_component.template.dart' as ng;
import 'package:todoapp/src/bloc_implementation/session_impl.dart';
import 'package:todoapp/src/repository_impl/preferences_interface_impl.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(PreferencesInterface, useClass: PreferencesInterfaceImpl),
  ClassProvider(Session, useClass: SessionImpl),
  ExistingProvider(Endpoints, Session)
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  fb.initializeApp(
    apiKey: "AIzaSyCT-v671MgA8YJh7mouPNZbxD3E2arH4Ck",
    authDomain: "todo-list-c45ee.firebaseapp.com",
    databaseURL: "https://todo-list-c45ee.firebaseio.com",
    projectId: "todo-list-c45ee",
    storageBucket: "todo-list-c45ee.appspot.com",
    messagingSenderId: "175688444480"
  );

  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/src/bloc/endpoints.dart';

abstract class Session {

  Endpoints endpoints;

  Session(this.endpoints){
    _isSignedIn.stream.listen((signedIn) {
      if(!signedIn) _logout();
    });
  }

  final BehaviorSubject<bool> _isSignedIn = BehaviorSubject<bool>();
  Stream<bool> get isSignedIn => _isSignedIn.stream;
  Sink<bool> get signedIn => _isSignedIn.sink;

  Future<String> signIn(String username, String password);
  void logout();

  void _logout() {
    logout();
    endpoints.logout();
  }
}
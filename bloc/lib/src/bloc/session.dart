import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/src/bloc/endpoints.dart';

abstract class Session implements Endpoints {

  //Collections.
  @protected
  final String userCollectionName = "users";
  @protected
  final String todoCollectionName = "todos";
  String userId;

  Session(){
    _isSignedIn.stream.listen((signedIn) {
      if(!signedIn) _logout();
    });
  }

  final BehaviorSubject<bool> _isSignedIn = BehaviorSubject<bool>();
  Stream<bool> get isSignedIn => _isSignedIn.stream;
  Sink<bool> get signedIn => _isSignedIn.sink;

  Future<String> signIn(String username, String password);
  @protected
  void logout();

  void _logout() {
    logout();
    userId = null;
  }
}
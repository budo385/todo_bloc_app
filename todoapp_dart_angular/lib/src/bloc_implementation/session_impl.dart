import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:bloc/bloc.dart';

class SessionBlocImpl extends Session {

  Auth _auth;

  SessionBlocImpl(this._auth, Endpoints endpoints) : super(endpoints);

  @override
  Future<String> signIn(String username, String password) {
    return _auth.signInWithEmailAndPassword(username, password).then( (userCredential) => userCredential.user.uid );
  }

  @override
  void logout() {
    _auth.signOut();
  }
}
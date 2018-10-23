import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionBlocImpl extends Session {

  FirebaseAuth _auth;
  SessionBlocImpl(this._auth, Endpoints endpoints) : super(endpoints);

  @override
  Future<String> signIn(String username, String password) {
    return _auth.signInWithEmailAndPassword(email: username, password: password).then( (firebaseUser) => firebaseUser.uid );
  }

  @override
  void logout() {
    _auth.signOut();
  }
}
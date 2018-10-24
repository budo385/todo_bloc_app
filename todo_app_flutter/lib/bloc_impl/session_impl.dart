import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SessionImpl extends Session {

  FirebaseAuth _auth;
  Firestore _firestore;
  SessionImpl(this._auth, this._firestore);

  @override
  Future<String> signIn(String username, String password) {
    return _auth.signInWithEmailAndPassword(email: username, password: password).then( (firebaseUser) => firebaseUser.uid );
  }

  @protected
  @override
  void logout() {
    _auth.signOut();
  }

  @override
  CollectionReference get userCollectionEndpoint => _firestore.collection(userCollectionName);

  @override
  CollectionReference get todoCollectionEndpoint => userCollectionEndpoint.document(this.userId).collection(todoCollectionName);
}
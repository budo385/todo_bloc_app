import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

class SessionImpl extends Session {

  Auth _auth = auth();
  Firestore _firestore = firestore();

  @override
  Future<String> signIn(String username, String password) {
    return _auth.signInWithEmailAndPassword(username, password).then( (userCredential) => userCredential.user.uid );
  }

  @override
  void logout() {
    _auth.signOut();
  }

  @override
  CollectionReference get todoCollectionEndpoint => userCollectionEndpoint.doc(this.userId).collection(todoCollectionName);

  @override
  CollectionReference get userCollectionEndpoint => _firestore.collection(userCollectionName);
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';

class EndpointsImpl extends Endpoints<DocumentReference, CollectionReference> {

  EndpointsImpl(Firestore firestore){
    userCollectionEndpoint = firestore.collection(userCollectionName);
  }

  @override
  CollectionReference get todoCollectionEndpoint => userCollectionEndpoint.document(this.userId).collection(todoCollectionName);
}

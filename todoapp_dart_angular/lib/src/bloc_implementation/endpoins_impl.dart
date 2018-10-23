import 'package:firebase/firestore.dart';
import 'package:bloc/bloc.dart';

class EndpointsImpl extends Endpoints<DocumentReference, CollectionReference> {

  EndpointsImpl(Firestore fStore){
    userCollectionEndpoint = fStore.collection(userCollectionName);
  }

  @override
  CollectionReference get todoCollectionEndpoint => userCollectionEndpoint.doc(this.userId).collection(todoCollectionName);
}
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class ToDoRepositoryImpl extends ToDoRepository {

  ToDoRepositoryImpl(Endpoints endpoints) : super(endpoints);

  @override
  Observable<List<TodoBloc>> getToDos() {
    return Observable(endpoints.todoCollectionEndpoint.snapshots())
        .map<List<TodoBloc>>((todosSnapshot) =>
        todosSnapshot.documents.map<TodoBloc>((documentSnapshot) => Todo.fromJson(documentSnapshot.data).toToDoBloc(documentSnapshot.documentID)).toList() );
  }

  @override
  Observable<TodoBloc> getTodo(String todoId) {
    return Observable.fromFuture(endpoints.todoCollectionEndpoint.document(todoId).get())
        .map<TodoBloc>( (documentSnapshot) => Todo.fromJson(documentSnapshot.data).toToDoBloc(documentSnapshot.documentID) );
  }

  @override
  Observable addUpdateToDo(TodoBloc todoBloc) {
    if(todoBloc.id.isEmpty)
      return Observable.fromFuture(endpoints.todoCollectionEndpoint.add(Todo.fromToDoBloc(todoBloc).toJson()));
    else
      return Observable.fromFuture(endpoints.todoCollectionEndpoint.document(todoBloc.id).updateData(Todo.fromToDoBloc(todoBloc).toJson()));
  }

  @override
  Observable<void> deleteToDoBloc(String todoId) {
    return Observable.fromFuture(endpoints.todoCollectionEndpoint.document(todoId).delete());
  }
}
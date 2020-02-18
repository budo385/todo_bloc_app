import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class ToDoRepositoryImpl extends ToDoRepository {

  ToDoRepositoryImpl(Endpoints endpoints) : super(endpoints);

  @override
  Stream<List<TodoBloc>> getToDos() {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.snapshots())
        .map<List<TodoBloc>>((todosSnapshot) =>
        todosSnapshot.documents.map<TodoBloc>((documentSnapshot) => Todo.fromJson(documentSnapshot.data).toToDoBloc(documentSnapshot.documentID)).toList() );
  }

  @override
  Stream<TodoBloc> getTodo(String todoId) {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.document(todoId).get())
        .map<TodoBloc>( (documentSnapshot) => Todo.fromJson(documentSnapshot.data).toToDoBloc(documentSnapshot.documentID) );
  }

  @override
  Stream addUpdateToDo(TodoBloc todoBloc) {
    if(todoBloc.id.isEmpty)
      return Stream.fromFuture(endpoints.todoCollectionEndpoint.add(Todo.fromToDoBloc(todoBloc).toJson()));
    else
      return Stream.fromFuture(endpoints.todoCollectionEndpoint.document(todoBloc.id).updateData(Todo.fromToDoBloc(todoBloc).toJson()));
  }

  @override
  Stream<void> deleteToDoBloc(String todoId) {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.document(todoId).delete());
  }
}

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ToDoRepositoryImpl extends ToDoRepository {

  ToDoRepositoryImpl(Endpoints endpoints) : super(endpoints);

  @override
  Stream<List<TodoBloc>> getToDos() {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.onSnapshot)
        .map<List<TodoBloc>>((todosSnapshot) =>
        todosSnapshot.docs.map<TodoBloc>((documentSnapshot) => Todo.fromJson(documentSnapshot.data()).toToDoBloc(documentSnapshot.id)).toList() );
  }

  @override
  Stream<TodoBloc> getTodo(String todoId) {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.doc(todoId).get())
        .map<TodoBloc>( (documentSnapshot) => Todo.fromJson(documentSnapshot.data()).toToDoBloc(documentSnapshot.id) );
  }

  @override
  Stream addUpdateToDo(TodoBloc todoBloc) {
    if(todoBloc.id.isEmpty)
      return Stream.fromFuture(endpoints.todoCollectionEndpoint.add(Todo.fromToDoBloc(todoBloc).toJson()));
    else
      return Stream.fromFuture(endpoints.todoCollectionEndpoint.doc(todoBloc.id).update(data: Todo.fromToDoBloc(todoBloc).toJson()));
  }

  @override
  Stream<void> deleteToDoBloc(String todoId) {
    return Stream.fromFuture(endpoints.todoCollectionEndpoint.doc(todoId).delete());
  }
}

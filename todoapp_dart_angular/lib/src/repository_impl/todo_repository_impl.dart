import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ToDoRepositoryImpl extends ToDoRepository {

  ToDoRepositoryImpl(Endpoints endpoints) : super(endpoints);

  @override
  Observable<List<TodoBloc>> getToDos() {
    return Observable(endpoints.todoCollectionEndpoint.onSnapshot)
        .map<List<TodoBloc>>((todosSnapshot) =>
        todosSnapshot.docs.map<TodoBloc>((documentSnapshot) => Todo.fromJson(documentSnapshot.data()).toToDoBloc(documentSnapshot.id)).toList() );
  }

  @override
  Observable<TodoBloc> getTodo(String todoId) {
    return Observable.fromFuture(endpoints.todoCollectionEndpoint.doc(todoId).get())
        .map<TodoBloc>( (documentSnapshot) => Todo.fromJson(documentSnapshot.data()).toToDoBloc(documentSnapshot.id) );
  }

  @override
  Observable addUpdateToDo(TodoBloc todoBloc) {
    if(todoBloc.id.isEmpty)
      return Observable.fromFuture(endpoints.todoCollectionEndpoint.add(Todo.fromToDoBloc(todoBloc).toJson()));
    else
      return Observable.fromFuture(endpoints.todoCollectionEndpoint.doc(todoBloc.id).update(data: Todo.fromToDoBloc(todoBloc).toJson()));
  }

  @override
  Observable<void> deleteToDoBloc(String todoId) {
    return Observable.fromFuture(endpoints.todoCollectionEndpoint.doc(todoId).delete());
  }
}
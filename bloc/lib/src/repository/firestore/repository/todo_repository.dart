import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'package:bloc/src/bloc/endpoints.dart';
import 'package:bloc/src/bloc/model/todo_bloc.dart';

abstract class ToDoRepository {

  @protected
  Endpoints endpoints;

  ToDoRepository(this.endpoints);

  Stream<List<TodoBloc>> getToDos();
  Stream<TodoBloc> getTodo(String todoId);
  Stream<dynamic> addUpdateToDo(TodoBloc todoBloc);
  Stream<void> deleteToDoBloc(String todoId);
}

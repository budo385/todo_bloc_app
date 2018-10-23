import 'package:bloc/bloc.dart';

class TodoListBlocImpl extends TodoListBloc {

  TodoListBlocImpl(ToDoRepository toDoRepository, Session session) : super(toDoRepository, session);
}
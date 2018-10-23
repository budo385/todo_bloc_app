import 'package:bloc/bloc.dart';

class TodoAddEditBlocImpl extends TodoAddEditBloc {

  TodoAddEditBlocImpl(ToDoRepository toDoRepository, Session session) : super(toDoRepository, session);
}
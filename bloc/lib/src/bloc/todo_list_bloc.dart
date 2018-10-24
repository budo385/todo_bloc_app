import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/src/bloc/base_bloc.dart';
import 'package:bloc/src/bloc/model/todo_bloc.dart';
import 'package:bloc/src/bloc/session.dart';
import 'package:bloc/src/repository/firestore/repository/todo_repository.dart';

abstract class TodoListBloc extends BaseBloc {

  ToDoRepository _toDoRepository;
  Session session;

  TodoListBloc(this._toDoRepository, this.session) {
    _todoAddUpdate.stream.listen(_addUpdateTodo);
    _todoChangeDone.stream.listen(_changeDone);
    _todoDelete.stream.listen(_deleteTodo);
    _getTodos();
  }

  final BehaviorSubject<List<TodoBloc>> _todos = BehaviorSubject<List<TodoBloc>>();
  Sink<List<TodoBloc>> get todosSink => _todos.sink;
  Stream<List<TodoBloc>> get todosStream => _todos.stream;

  final BehaviorSubject<TodoBloc> _todoAddUpdate = BehaviorSubject<TodoBloc>();
  Sink<TodoBloc> get todoAddUpdateSink => _todoAddUpdate.sink;

  final BehaviorSubject<String> _todoChangeDone = BehaviorSubject<String>();
  Sink<String> get todoChangeDoneSink => _todoChangeDone.sink;

  final BehaviorSubject<String> _todoDelete = BehaviorSubject<String>();
  Sink<String> get todoDeleteSink => _todoDelete.sink;

  //Private
  void _getTodos(){
    showProgress.add(true);
    _toDoRepository.getToDos()
        .listen((todosList) {
      todosSink.add(todosList);
      showProgress.add(false);
    },
        onError: (err) {
          showProgress.add(false);
          error.add(err.toString());
        });

  }

  void _addUpdateTodo(TodoBloc todoBloc){
    showProgress.add(true);
    _toDoRepository.addUpdateToDo(todoBloc)
        .doOnDone( () => showProgress.add(false) )
        .listen((_) {
    },
        onError: (err) {
          error.add(err.toString());
        });
  }

  void _deleteTodo(String todoId){
    showProgress.add(true);
    _toDoRepository.deleteToDoBloc(todoId)
        .doOnDone( () => showProgress.add(false) )
        .listen((_) {
    },
        onError: (err) {
          error.add(err.toString());
        });
  }

  void _changeDone(String todoId) {
    TodoBloc todoBloc = _todos.value.firstWhere((todoBloc) => todoBloc.id == todoId);
    todoBloc.ended = todoBloc.done ? null : DateTime.now();
    todoBloc.done = !todoBloc.done;
    _addUpdateTodo(todoBloc);
  }

  @override
  void dispose() {
    _todos.close();
    _todoAddUpdate.close();
    _todoChangeDone.close();
    _todoDelete.close();
    super.dispose();
  }
}

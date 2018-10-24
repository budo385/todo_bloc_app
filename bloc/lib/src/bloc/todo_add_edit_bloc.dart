import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'package:bloc/src/bloc/base_bloc.dart';
import 'package:bloc/src/bloc/model/todo_bloc.dart';
import 'package:bloc/src/bloc/session.dart';
import 'package:bloc/src/repository/firestore/repository/todo_repository.dart';

class TodoAddEditBloc extends BaseBloc {

  ToDoRepository _toDoRepository;
  TodoAddEditBloc(this._toDoRepository) {
    _todo.stream.listen(_onTodoAdded);
    _addUpdate.stream.listen(_addUpdateTodo);
    _todoId.stream.listen(_getBloc);
  }

  final BehaviorSubject<TodoBloc> _todo = BehaviorSubject<TodoBloc>();
  Sink<TodoBloc> get todoSink => _todo.sink;
  Stream<TodoBloc> get todoStream => _todo.stream;

  final BehaviorSubject<String> _todoId = BehaviorSubject<String>();
  Sink<String> get todoIdSink => _todoId.sink;

  final _title = BehaviorSubject<String>();
  Sink<String> get titleSink => _title.sink;
  Stream<String> get titleStream => _title.stream;

  final _description = BehaviorSubject<String>();
  Sink<String> get descriptionSink => _description.sink;
  Stream<String> get descriptionStream => _description.stream;

  final BehaviorSubject<bool> _addUpdate = BehaviorSubject<bool>();
  Sink<bool> get addUpdateSink => _addUpdate.sink;

  final BehaviorSubject<int> _todoError = BehaviorSubject<int>();
  Stream<int> get todoErrorStream => _todoError.stream;

  final BehaviorSubject<bool> _closeDetail = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get closeDetailStream => _closeDetail.stream;

  //Private
  void _onTodoAdded(TodoBloc todo) {
    titleSink.add(todo.title);
    descriptionSink.add(todo.description);
  }

  void _getBloc(String todoId){
    if(todoId.isEmpty){
      _todo.add(TodoBloc("", false, DateTime.now(), null, "", ""));
      return;
    }

    showProgress.add(true);
    _toDoRepository.getTodo(todoId)
        .doOnDone( () => showProgress.add(false) )
        .listen((todo) => todoSink.add(todo) ,
        onError: (err) => error.add(err.toString()) );
  }

  void _addUpdateTodo(bool addUpdate) {
    if(!addUpdate) return;
    //Check required.
    if(_title.value.isEmpty)
      _todoError.sink.add(0);
    else if(_description.value.isEmpty)
      _todoError.sink.add(1);
    else
      _todoError.sink.add(-1);

    if(_todoError.value >= 0)
      return;

    final TodoBloc todoBloc = _todo.value == null ? TodoBloc("", false, DateTime.now(), null, null, null) : _todo.value;
    todoBloc.title = _title.value;
    todoBloc.description = _description.value;

    showProgress.add(true);
    _toDoRepository.addUpdateToDo(todoBloc)
        .doOnDone( () => showProgress.add(false) )
        .listen((_) => _closeDetail.add(true) ,
        onError: (err) => error.add( err.toString()) );
  }

  @override
  void dispose() {
    _todo.close();
    _todoId.close();
    _title.close();
    _description.close();
    _addUpdate.close();
    _todoError.close();
    _closeDetail.close();
    super.dispose();
  }
}

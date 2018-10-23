import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'package:bloc/src/bloc/base_bloc.dart';
import 'package:bloc/src/bloc/model/todo_bloc.dart';
import 'package:bloc/src/bloc/session.dart';
import 'package:bloc/src/repository/firestore/repository/todo_repository.dart';

abstract class TodoAddEditBloc extends BaseBloc {

  ToDoRepository _toDoRepository;

  TodoAddEditBloc(this._toDoRepository, Session session) : super(session) {
    _titleDescr.stream.listen(_addUpdateTodo);
    _todoId.stream.listen(_getBloc);
  }

  final BehaviorSubject<TodoBloc> _todo = BehaviorSubject<TodoBloc>();
  Sink<TodoBloc> get todoSink => _todo.sink;
  Stream<TodoBloc> get todoStream => _todo.stream;

  final BehaviorSubject<String> _todoId = BehaviorSubject<String>(seedValue: "");
  Sink<String> get todoIdSink => _todoId.sink;

  final BehaviorSubject<Tuple2<String, String>> _titleDescr = BehaviorSubject<Tuple2<String, String>>();
  Sink<Tuple2<String, String>> get titleDescrSink => _titleDescr.sink;

  final BehaviorSubject<int> _todoError = BehaviorSubject<int>();
  Stream<int> get todoErrorStream => _todoError.stream;

  final BehaviorSubject<bool> _closeDetail = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get closeDetailStream => _closeDetail.stream;

  //Private
  void _getBloc(String todoId){
    if(todoId.isEmpty){
      _todo.add(TodoBloc("", false, DateTime.now(), null, null, null));
      return;
    }

    showProgress.add(true);
    _toDoRepository.getTodo(todoId)
        .doOnDone( () => showProgress.add(false) )
        .listen((todo) => todoSink.add(todo) ,
        onError: (err) => error.add(err.toString()) );
  }

  void _addUpdateTodo(Tuple2<String, String> titleDecr) {
    final String title = titleDecr.item1;
    final String descr = titleDecr.item2;
    //Check required.
    if(title.isEmpty)
      _todoError.sink.add(0);
    else if(descr.isEmpty)
      _todoError.sink.add(1);
    else
      _todoError.sink.add(-1);

    if(_todoError.value >= 0)
      return;

    final TodoBloc todoBloc = _todo.value == null ? TodoBloc("", false, DateTime.now(), null, null, null) : _todo.value;
    todoBloc.title = title;
    todoBloc.description = descr;

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
    _titleDescr.close();
    _todoError.close();
    _closeDetail.close();
    super.dispose();
  }
}

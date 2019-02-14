import 'package:bloc/src/bloc/model/todo_bloc.dart';

class Todo {
  bool done;
  DateTime created;
  DateTime ended;
  String title;
  String description;

  Todo(this.done, this.created, this.ended, this.title, this.description);

  Todo.fromJson(Map<String, dynamic> json)
      : done = json['done'],
        created = DateTime.fromMillisecondsSinceEpoch(json['created']),
        ended = json['ended'] != null ? DateTime.fromMicrosecondsSinceEpoch(json['ended']) : null,
        title = json['title'],
        description = json['description'];

  Todo.fromToDoBloc(TodoBloc todoBloc)
      : done = todoBloc.done,
        created = todoBloc.created,
        ended = todoBloc.ended,
        title = todoBloc.title,
        description = todoBloc.description;

  Map<String, dynamic> toJson() =>
      {
        'done' : done,
        'created' : created?.millisecondsSinceEpoch,
        'ended' : ended?.millisecondsSinceEpoch,
        'title' :title,
        'description' :description
      };

  TodoBloc toToDoBloc(String todoId) => TodoBloc(todoId, done, created, ended, title, description);
}
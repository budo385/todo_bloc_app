import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/di/inject.dart';
import 'package:todo_app_flutter/localization.dart';
import 'package:todo_app_flutter/ui/base/base_bloc_scaffold_widget.dart';

class TodoAddEdit extends StatefulWidget {

  final todoId;
  TodoAddEdit(this.todoId);

  @override
  State<StatefulWidget> createState() => _TodoAddEditState(todoId);
}

class _TodoAddEditState extends State<TodoAddEdit>{

  TodoAddEditBloc _todoAddEditBloc = Injection.injector.get<TodoAddEditBloc>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  _TodoAddEditState(String todoId){
    _todoAddEditBloc.todoIdSink.add(todoId);
  }

  @override
  void initState() {
    super.initState();
    _todoAddEditBloc.todoStream.first.then((todo) {
      _titleController.text = todo.title;
      _descriptionController.text = todo.description;
    });

    _todoAddEditBloc.closeDetailStream.listen((close) {
      if (close) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocScaffoldWidget(_todoAddEditBloc,
        AppBar(
          title: Text(Localization.of(context).todo),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.done), onPressed: () => _todoAddEditBloc.addUpdateSink.add(true),),
          ],
        ),
        SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Username input.
                  StreamBuilder<int>(
                    stream: _todoAddEditBloc.todoErrorStream,
                    builder: (BuildContext context, AsyncSnapshot errorSnapshot) {
                      return TextField(
                        onChanged: (text) => _todoAddEditBloc.titleSink.add(text),
                        decoration: InputDecoration(hintText: Localization.of(context).title, labelText: Localization.of(context).title, errorText: errorSnapshot.data == 0 ? Localization.of(context).titleEmpty : null),
                        controller: _titleController,
                      );
                    },
                  ),
                  //Password input.
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: StreamBuilder<int>(
                      stream: _todoAddEditBloc.todoErrorStream,
                      builder: (BuildContext context, AsyncSnapshot errorSnapshot) {
                        return TextField(
                          maxLines: 20,
                          onChanged: (text) => _todoAddEditBloc.descriptionSink.add(text),
                          decoration: InputDecoration(hintText: Localization.of(context).description, labelText: Localization.of(context).description, errorText: errorSnapshot.data == 1 ? Localization.of(context).descriptionEmpty : null),
                          controller: _descriptionController,
                        );
                      },
                    ),
                  ),
                ]
            )
        )
    );
  }
}
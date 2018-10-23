import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_flutter/di/inject.dart';
import 'package:todo_app_flutter/localization.dart';
import 'package:todo_app_flutter/ui/base/base_bloc_scaffold_widget.dart';
import 'package:todo_app_flutter/ui/todo_add_edit/todo_add_edit.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoListBloc = Injection.injector.get<TodoListBloc>();

  @override
  void initState() {
    super.initState();
    _todoListBloc.session.isSignedIn.listen((isSignedIn) {
      if(!isSignedIn && context != null)
        Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: BaseBlocScaffoldWidget(_todoListBloc,
            AppBar(
              title: Text(Localization.of(context).todoList),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: () => _goToDetail(context, ""),),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: StreamBuilder<List<TodoBloc>>(
                        stream: _todoListBloc.todosStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.data == null)
                            return Container();
                          else
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                final backgroundColor = snapshot.data[index].done ? Theme.of(context).buttonColor : Theme.of(context).accentColor;
                                final todoId = snapshot.data[index].id;
                                return Dismissible(key: Key(snapshot.data[index].id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      _todoListBloc.todoDeleteSink.add(todoId);
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                          decoration: BoxDecoration(color: backgroundColor),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                  key: Key(snapshot.data[index].id),
                                                  onTap: () {
                                                    _goToDetail(context, todoId);
                                                  },
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                  leading: Container(
                                                    padding: EdgeInsets.only(right: 12.0),
                                                    decoration: new BoxDecoration(
                                                        border: new Border(
                                                            right: new BorderSide(width: 1.0, color: Colors.white24))),
                                                    child: Icon(Icons.assignment, color: Colors.white),
                                                  ),
                                                  title: Text(
                                                    snapshot.data[index].title,
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                  subtitle: Text(snapshot.data[index].description,
                                                    style: TextStyle(color: Colors.white),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  trailing: _todoDoneWidget(context, snapshot.data[index].done, snapshot.data[index].id)),
                                              //Icon(Icons.keyboard_arrow_right, size: 30.0)),
                                              _dateWidget(context, snapshot.data[index].created, snapshot.data[index].ended )
                                            ],
                                          )
                                      ),
                                    )
                                );
                              },
                            );
                        },
                      )
                  ),
//              ),
                ],
              ),
            )
        ),
        onWillPop: () => _requestPop(context)
    );
  }

  void _goToDetail(BuildContext context, String todoId) {
    Navigator.push( context, MaterialPageRoute(builder: (context) => TodoAddEdit(todoId)));
  }

  Widget _todoDoneWidget(BuildContext buildContext, bool done, String todoId) {
    Widget icon = Icon(Icons.warning);
    if(done) icon = Icon(Icons.done);
    return IconButton(icon: icon,
        color: Theme.of(buildContext).backgroundColor,
        onPressed: (){
          _todoListBloc.todoChangeDoneSink.add(todoId);
        });
  }

  Widget _dateWidget(BuildContext buildContext, DateTime created, DateTime ended) {
    Widget endedWidget = Container();
    if(ended != null) endedWidget = Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Text(Localization.of(buildContext).ended + " " + DateFormat('yyyy-MM-dd kk:mm').format(ended), style: TextStyle(color: Theme.of(buildContext).backgroundColor),),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Localization.of(buildContext).created + " " + DateFormat('yyyy-MM-dd kk:mm').format(created), style: TextStyle(color: Theme.of(buildContext).backgroundColor),),
        ),
        endedWidget,
      ],
    );
  }

  Future<bool> _requestPop(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(Localization.of(context).signoutTitle),
        content: new Text(Localization.of(context).signoutDescr),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              _todoListBloc.session.signedIn.add(false);
            },
            child: Text(Localization.of(context).ok),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Localization.of(context).cancel),
          ),
        ],
      );
    });
    return new Future.value(false);
  }
}
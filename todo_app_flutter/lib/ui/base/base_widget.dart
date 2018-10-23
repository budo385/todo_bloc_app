import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/localization.dart';

abstract class BaseWidget extends StatefulWidget {

  final BaseBloc baseBloc;
  Widget body(BuildContext context);

  BaseWidget(this.baseBloc);

  @override
  State<StatefulWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {

  void _showErrorDialog(BuildContext context, String errorText){
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(Localization.of(context).errorTitle),
        content: new Text(errorText),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Localization.of(context).ok),
          ),
        ],
      );
    });
  }

  Widget _progressLayoutWidget() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.baseBloc.progressVisible,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.data)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return new Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.baseBloc.errorStream.listen((error) {
      if(error.isNotEmpty)
        _showErrorDialog(context, error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        widget.body(context),
        _progressLayoutWidget(),
      ],
    );
  }

  @override
  void dispose() {
    widget.baseBloc.dispose();
    super.dispose();
  }
}
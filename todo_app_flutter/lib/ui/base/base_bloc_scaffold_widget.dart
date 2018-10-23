import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/localization.dart';
import 'package:todo_app_flutter/ui/base/base_bloc_widget.dart';

class BaseBlocScaffoldWidget extends BaseBlocWidget {

  final AppBar _appBar;
  final String _appBarTitle;

  BaseBlocScaffoldWidget(BaseBloc baseBloc, this._appBar, Widget body) : _appBarTitle = null,  super(baseBloc, body);
  BaseBlocScaffoldWidget.withTitle(BaseBloc baseBloc, this._appBarTitle, Widget body) : _appBar = null, super(baseBloc, body);

  @override
  Widget body (BuildContext context) {
    if (_appBar == null && _appBarTitle == null)
      return SafeArea(child: Scaffold( appBar: AppBar( title: new Text(Localization.of(context).appName)), body: super.body(context)));
    else if (_appBar == null && _appBarTitle != null)
      return SafeArea(child: Scaffold( appBar: AppBar( title: new Text(_appBarTitle)), body: super.body(context) ));
    else
      return SafeArea(child: Scaffold( appBar: _appBar, body: super.body(context)));
  }
}
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/ui/base/base_widget.dart';

class BaseBlocWidget extends BaseWidget {

  final Widget _body;

  BaseBlocWidget(BaseBloc baseBloc, this._body) : super(baseBloc);

  @override
  Widget body (BuildContext context) {
    return _body;
  }
}
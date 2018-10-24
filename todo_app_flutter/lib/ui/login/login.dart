import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/di/inject.dart';
import 'package:todo_app_flutter/localization.dart';
import 'package:todo_app_flutter/ui/base/base_bloc_scaffold_widget.dart';

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _loginBloc = Injection.injector.get<LoginBloc>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSavedUsername();

    _loginBloc.usernameStream.first.then( (username) => _usernameController.text = username );

    _loginBloc.passwordStream.isEmpty.then((empty) {
      if(empty)
        _passwordController.text = "";
    });

    _loginBloc.session.isSignedIn.listen((isSignedIn) {
      if(isSignedIn && context != null)
        Navigator.of(context).pushReplacementNamed('/todos');
    });
  }

  void getSavedUsername() async => _usernameController.text = await _loginBloc.usernameStream.first;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BaseBlocScaffoldWidget.withTitle(
        _loginBloc,
        Localization.of(context).appName,
        SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Username input.
                StreamBuilder<int>(
                  stream: _loginBloc.loginErrorStream,
                  builder: (BuildContext context, AsyncSnapshot errorSnapshot) {
                    return TextField(
                      onChanged: (text) => _loginBloc.usernameSink.add(text),
                      decoration: InputDecoration(hintText: Localization.of(context).username, labelText: Localization.of(context).username, errorText: errorSnapshot.data == 0 ? Localization.of(context).usernameEmpty : null),
                      controller: _usernameController,
                    );
                  },
                ),
                //Password input.
                StreamBuilder<int>(
                  stream: _loginBloc.loginErrorStream,
                  builder: (BuildContext context, AsyncSnapshot errorSnapshot) {
                    return TextField(
                      obscureText: true,
                      onChanged: (text) => _loginBloc.passwordSink.add(text),
                      decoration: InputDecoration(hintText: Localization.of(context).password, labelText: Localization.of(context).password, errorText: errorSnapshot.data == 1 ? Localization.of(context).passwordEmpty : null),
                      controller: _passwordController,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: MaterialButton(
                    color: Theme.of(context).buttonColor,
                    onPressed: () {
                      _loginBloc.loginSink.add(true);
                    },
                    child: Text(Localization.of(context).login),
                  ),
                ),
              ]
          ),
        )
    );
  }
}
import 'package:bloc/bloc.dart';

class LoginBlocImpl extends LoginBloc {

  LoginBlocImpl(PreferencesInterface preferencesInterface, Session session) : super(preferencesInterface, session);
}
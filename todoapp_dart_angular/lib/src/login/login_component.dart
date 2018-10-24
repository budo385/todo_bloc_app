import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:bloc/bloc.dart';
import 'package:todoapp/src/base/base_bloc_component.dart';

@Component(
  selector: 'login-component',
  templateUrl: 'login_component.html',
  directives: [
    coreDirectives,
    formDirectives,
    MaterialButtonComponent,
    MaterialSpinnerComponent,
    materialInputDirectives,
    BaseBlocComponent,
  ],
  providers: [
    overlayBindings,
    ClassProvider(LoginBloc),
    ExistingProvider(BaseBloc, LoginBloc)
  ],
  pipes: [commonPipes],
)
class LoginComponent implements OnDestroy {
  String userNameLabel = "Username";
  String passwordLabel = "Password";
  String userNameErrString = "Username required!";
  String passwordErrString = "Password required!";
  String signIn = "Sign In";

  LoginBloc loginBloc;

  LoginComponent(this.loginBloc);

  @override
  void ngOnDestroy() {
    loginBloc.dispose();
  }
}
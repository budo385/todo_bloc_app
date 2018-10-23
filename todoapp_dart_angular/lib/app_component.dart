import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:bloc/bloc.dart';
import 'package:todoapp/src/login/login_component.dart';
import 'package:todoapp/src/todo_list/todo_list_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    coreDirectives,
    LoginComponent,
    TodoListComponent,
  ],
  providers: [
    overlayBindings,
  ],
  pipes: [commonPipes],
)
class AppComponent {

  String appTitle = "Todo app";
  Session session;

  AppComponent(this.session);
}

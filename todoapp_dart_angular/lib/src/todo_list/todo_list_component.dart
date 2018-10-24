import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:bloc/bloc.dart';
import 'package:todoapp/src/base/base_bloc_component.dart';
import 'package:todoapp/src/repository_impl/todo_repository_impl.dart';
import 'package:todoapp/src/todo_detail/todo_detail.dart';

@Component(
  selector: 'todo-list',
  styleUrls: ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: [
    coreDirectives,
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
    BaseBlocComponent,
    TodoDetailComponent,
  ],
  providers: [
    ClassProvider(ToDoRepository, useClass: ToDoRepositoryImpl),
    ClassProvider(TodoListBloc),
    ExistingProvider(BaseBloc, TodoListBloc)
  ],
  pipes: [commonPipes],
)
class TodoListComponent implements OnDestroy {

  String logOutStr = "Log out";

  String todoId;

  TodoListBloc todoListBloc;

  TodoListComponent(this.todoListBloc);

  void showDetail(String todoId) {
    this.todoId = todoId;
  }

  void closeDetail(bool close) {
    if(close)
      this.todoId = null;
  }

  void addNew() => this.todoId = "";

  void deleteItem(String todoId) {
    this.todoId = null;
    todoListBloc.todoDeleteSink.add(todoId);
  }

  void logout(){
    todoListBloc.session.signedIn.add(false);
  }

  @override
  void ngOnDestroy() {
    todoListBloc.dispose();
  }
}

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:bloc/bloc.dart';
import 'package:todoapp/src/base/base_bloc_component.dart';
import 'package:todoapp/src/repository_impl/todo_repository_impl.dart';

@Component(
  selector: 'todo-detail',
  templateUrl: 'todo_detail.html',
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
    ClassProvider(ToDoRepository, useClass: ToDoRepositoryImpl),
    ClassProvider(TodoAddEditBloc),
    ExistingProvider(BaseBloc, TodoAddEditBloc)
  ],
  pipes: [commonPipes],
)

class TodoDetailComponent implements OnDestroy, AfterChanges {

  @Input()
  String todoId;

  @Output()
  Stream<bool> closeDetailStream;

  TodoAddEditBloc todoAddEditBloc;

  String titleStr = "Title";
  String descriptionStr = "Description";
  String titleErrString = "Title required!";
  String descriptionErrString = "Description required!";
  String saveStr = "Save";

  TodoDetailComponent(this.todoAddEditBloc){
    closeDetailStream =  todoAddEditBloc.closeDetailStream;
  }

  @override
  void ngAfterChanges() {
    todoAddEditBloc.todoIdSink.add(todoId);
  }

  @override
  void ngOnDestroy() {
    todoAddEditBloc.dispose();
  }
}
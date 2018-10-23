import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:bloc/bloc.dart';

@Component(
  selector: 'base-bloc',
  templateUrl: 'base_bloc_component.html',
  styleUrls: ['base_bloc_component.css'],
    directives: [
    coreDirectives,
    MaterialButtonComponent,
    MaterialSpinnerComponent,
    MaterialDialogComponent,
    ModalComponent,
//    AutoDismissDirective,
//    AutoFocusDirective,
//    NgFor,
//    NgIf
  ],
  pipes: [commonPipes],
  providers: [
    overlayBindings,
  ]
)
class BaseBlocComponent {

  String close = "Close";
  String errorString = "Error";
  BaseBloc baseBlock;

  BaseBlocComponent(this.baseBlock);
}
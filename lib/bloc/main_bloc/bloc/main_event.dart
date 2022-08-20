part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainEventSetIndexPage extends MainEvent {
  int indexPage;
  MainEventSetIndexPage(this.indexPage);
  @override
  List<Object?> get props => [indexPage];
}

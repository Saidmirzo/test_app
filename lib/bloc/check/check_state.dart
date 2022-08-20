part of 'check_bloc.dart';

abstract class CheckState extends Equatable {
  const CheckState();
}

class CheckInitial extends CheckState {
  const CheckInitial();
  @override
  List<Object?> get props => [];
}

class CheckStateComlated extends CheckState {
  List<TodosModel> listTodos;
  CheckStateComlated(this.listTodos);
  @override
  List<Object?> get props => [listTodos];
}

class ChkeckStateProgress extends CheckState {
  @override
  List<Object?> get props => [];
}

class CheckStateFailed extends CheckState {
  String message;
  CheckStateFailed(this.message);
  @override
  List<Object?> get props => [message];
}

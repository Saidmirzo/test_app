part of 'check_bloc.dart';

abstract class CheckEvent extends Equatable {
  const CheckEvent();

 
}
class CheckEventLoadTodos extends CheckEvent{
  const CheckEventLoadTodos();
  
  @override
  List<Object?> get props => [];
}


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(0)) {
    on<MainEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MainEventSetIndexPage>(
      (event, emit) {
        emit(MainState(event.indexPage));
      },
    );
  }
}

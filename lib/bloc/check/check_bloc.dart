import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/todos_model.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc() : super(CheckInitial()) {
    on<CheckEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CheckEventLoadTodos>(
      (event, emit) async {
        try {
          List<TodosModel> listTodods = [];
          emit(ChkeckStateProgress());
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listTodods.add(TodosModel.fromJson(item));
            }
            emit(CheckStateComlated(listTodods));
          } else {}
        } on SocketException {
          emit(CheckStateFailed('Connection error'));
        } catch (e) {
          emit(CheckStateFailed(e.toString()));
        }
      },
    );
  }
}

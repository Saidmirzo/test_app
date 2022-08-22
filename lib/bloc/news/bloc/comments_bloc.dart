import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/coments_model.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CommentsEventLoadComments>((event, emit) async {
       try {
          emit( CommentsStateInProgress());
          List<CommentsModel> listComments = [];
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listComments.add(CommentsModel.fromJson(item));
            }
            emit(CommentsStateComplated( listComments));
          } else {}
        } on SocketException {
          emit( CommentsStateFailed('Connection error'));
        } catch (e) {
          emit(CommentsStateFailed(e.toString()));
        }
    },);
  }
}

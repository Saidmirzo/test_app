import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/coments_model.dart';

import '../../domain/models/post_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsStateInitial()) {
    on<NewsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NewsEventLoadPosts>(
      ((event, emit) async {
        try {
          emit(const NewsStateInProgress());
          List<PostsModel> listPosts = [];
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listPosts.add(PostsModel.fromJson(item));
            }
            emit(NewsStateComplatedLoadPosts(listPosts: listPosts));
          } else {}
        } on SocketException {
          emit(const NewsStateFailed('Connecyion error'));
        } catch (e) {
          emit(NewsStateFailed(e.toString()));
        }
      }),
    );
  }
}

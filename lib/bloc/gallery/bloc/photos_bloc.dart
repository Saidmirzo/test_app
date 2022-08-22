import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/photos_model.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc() : super(PhotosInitial()) {
    on<PhotosEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PhotosEventLoadPhotos> ((event, emit) async {
        try {
          List<PhotosModel> listPhotos = [];
          emit( PhotosStateInProgress());
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listPhotos.add(PhotosModel.fromJson(item));
            }
            emit(PhotosStateComplated(listPhotos));
          } else {}
        } on SocketException {
          emit( PhotosStateFailed('Connection error'));
        } catch (e) {
          emit(PhotosStateFailed(e.toString()));
        }
    },);
  }
}

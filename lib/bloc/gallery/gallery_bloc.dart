import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/alboms_model.dart';
import 'package:news/domain/models/photos_model.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GalleryEventLoadAlboms>(
      (event, emit) async {
        try {
          List<AlbomsModel> listAlboms = [];
          emit(const GalleryStateInProgress());
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listAlboms.add(AlbomsModel.fromJson(item));
            }
            emit(GalleryStateComplatedLoaded(listAlboms: listAlboms));
          } else {}
        } on SocketException {
          emit(const GalleryStateFailed('Connection error'));
        } catch (e) {
          emit(GalleryStateFailed(e.toString()));
        }
      },
    );
   
  }
}

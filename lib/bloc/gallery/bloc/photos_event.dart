part of 'photos_bloc.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  
}
class PhotosEventLoadPhotos extends PhotosEvent{
@override
  List<Object> get props => [];
}

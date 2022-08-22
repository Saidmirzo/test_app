part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();
}

class GalleryEventLoadAlboms extends GalleryEvent {
  const GalleryEventLoadAlboms();
  
  @override
  List<Object?> get props => [];

}


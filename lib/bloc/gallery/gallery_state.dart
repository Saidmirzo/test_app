part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
  
 
}

class GalleryInitial extends GalleryState {
  @override
  List<Object?> get props => [];
}

class GalleryStateInProgress extends GalleryState {
  const GalleryStateInProgress();

  @override
  List<Object?> get props => [];
}

class GalleryStateComplatedLoaded extends GalleryState {
  const GalleryStateComplatedLoaded({required this.listAlboms});
  final List<AlbomsModel> listAlboms;
  

  @override
  List<Object?> get props => [listAlboms];
}



class GalleryStateFailed extends GalleryState {
  const GalleryStateFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();
}

class PhotosInitial extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosStateInProgress extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosStateComplated extends PhotosState {
  List<PhotosModel> listPgotos;
  PhotosStateComplated(this.listPgotos);
  @override
  List<Object> get props => [listPgotos];
}

class PhotosStateFailed extends PhotosState {
  String message;
  PhotosStateFailed(this.message);
  @override
  List<Object> get props => [message];
}

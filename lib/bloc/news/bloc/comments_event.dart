part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class CommentsEventLoadComments extends CommentsEvent {
  CommentsEventLoadComments();
  @override
  List<Object?> get props => [];
}


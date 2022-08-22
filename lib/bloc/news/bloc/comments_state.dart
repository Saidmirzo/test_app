part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsInitial extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsStateComplated extends CommentsState {
  List<CommentsModel> listComments;
  CommentsStateComplated(this.listComments);
  @override
  List<Object> get props => [listComments];
}

class CommentsStateFailed extends CommentsState {
  String message;
  CommentsStateFailed(this.message);
  @override
  List<Object> get props => [message];
}

class CommentsStateInProgress extends CommentsState {
  @override
  List<Object> get props => [];
}

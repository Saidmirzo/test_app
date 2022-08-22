part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsStateInitial extends NewsState {
  const NewsStateInitial();

  @override
  List<Object?> get props => [];
}

class NewsStateInProgress extends NewsState {
  const NewsStateInProgress();
  @override
  List<Object?> get props => [];
}

class NewsStateComplatedLoadPosts extends NewsState {
  const NewsStateComplatedLoadPosts({required this.listPosts});
  final List<PostsModel> listPosts;
  @override
  List<Object?> get props => [listPosts];
}


class NewsStateFailed extends NewsState {
  const NewsStateFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

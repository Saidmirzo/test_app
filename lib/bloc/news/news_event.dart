part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}



class NewsEventLoadPosts extends NewsEvent {
  const NewsEventLoadPosts();

  @override
  List<Object?> get props => [];
}


class NewsEventLoadComments extends NewsEvent {
  const NewsEventLoadComments();

  @override
  List<Object?> get props => [];
}

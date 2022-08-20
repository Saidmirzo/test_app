part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  @override
  List<Object?> get props => [];

}

class ContactStateInProgress extends ContactState {
  const ContactStateInProgress();

  @override
  List<Object?> get props => [];
}

class ContactStateComplatedLoadPosts extends ContactState {
  const ContactStateComplatedLoadPosts({required this.listContacts});
  final List<UsersModel> listContacts;
  @override
  List<Object?> get props => [listContacts];
}


class ContactStateFailed extends ContactState {
  const ContactStateFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
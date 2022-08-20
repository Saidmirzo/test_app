import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/users_model.dart';

import '../../domain/models/alboms_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<ContactEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ContactEventLoadContact>(
      (event, emit) async {
        try {
          List<UsersModel> listContatct = [];
          emit(ContactStateInProgress());
          var response = await get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)) {
              listContatct.add(UsersModel.fromJson(item));
            }
            emit(ContactStateComplatedLoadPosts(listContacts: listContatct));
          } else {}
        } on SocketException {
          emit(const ContactStateFailed('Connectiuon error'));
        } catch (e) {
          emit(ContactStateFailed(e.toString()));
        }
      },
    );
  }
}

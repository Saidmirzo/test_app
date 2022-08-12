// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:news/domain/models/coments_model.dart';
import 'package:news/domain/models/post_model.dart';

class MainProvider extends ChangeNotifier {
  String s = 'salom';
  int nBarIndex = 0;
  int indexPost = 0;

  Map<String, bool> isLoaded = {
    'post': false,
    'comment': false,
  };
  List<PostsModel> listPosts = [];
  Future loadPosts() async {
    try {
      var response =
          await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        for (final item in jsonDecode(response.body)) {
          listPosts.add(PostsModel.fromJson(item));
        }
        isLoaded['post'] = true;
        notifyListeners();
      } else {
        //_showMessage('Unknown error');
      }
    } on SocketException {
      // _showMessage('Connection error');
      //_loadData();

    } catch (e) {
      //_showMessage(e.toString());
    }
  }

  setNBarIndex(int num) {
    nBarIndex = num;
    notifyListeners();
  }

  setIndexPost(int num) {
    indexPost = num;
    notifyListeners();
  }

  setIsLoaded(String key, bool b) {
    isLoaded[key] = b;
    notifyListeners();
  }

  //---------------------------------------------------------
  //---------------------------------------------------------
  List<CommentsModel> listComments = [];
  Future loadComments() async {
    try {
      var response =
          await get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        for (final item in jsonDecode(response.body)) {
          listComments.add(CommentsModel.fromJson(item));
        }
        isLoaded['comment'] = true;
        notifyListeners();
      } else {
        //_showMessage('Unknown error');
      }
    } on SocketException {
      // _showMessage('Connection error');
      //_loadData();

    } catch (e) {
      //_showMessage(e.toString());
    }
  }
}

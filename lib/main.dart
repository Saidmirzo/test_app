import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/check/check_bloc.dart';
import 'package:news/bloc/contacts/contact_bloc.dart';
import 'package:news/bloc/gallery/gallery_bloc.dart';
import 'package:news/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:news/screen_pages/main_page.dart';

import 'bloc/news/news_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: ((context) => NewsBloc()),
        ),
         BlocProvider<ContactBloc>(
          create: ((context) => ContactBloc()),
        ),
        BlocProvider<GalleryBloc>(
          create: ((context) => GalleryBloc()),
        ),
        BlocProvider<CheckBloc>(
          create: ((context) => CheckBloc()),
        ),
        BlocProvider<MainBloc>(
          create: ((context) => MainBloc()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/domain/providers/mainProvider.dart';
import 'package:news/screenPages/mainPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child:const  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  MainPage(),
      ),
    );
  }
}


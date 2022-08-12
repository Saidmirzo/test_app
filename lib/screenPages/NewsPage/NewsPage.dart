import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/domain/providers/mainProvider.dart';
import 'package:news/utils/const.dart';
import 'package:provider/provider.dart';

import '../../domain/Widgets/widgets.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animG;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animG =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
            .animate(_controller);
    context.read<MainProvider>().loadPosts();
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    late List listnews;
     return Consumer<MainProvider>(builder: (context, provider, child) {
    if (context.watch<MainProvider>().isLoaded['post'] ?? false) {
      return Container(
        color: const Color(0xff0F0C20),
        child: ListView(
          children: List.generate(
              context.watch<MainProvider>().listPosts.length, (index) {
            var list = context.watch<MainProvider>().listPosts;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xff221B44),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      list[index].title!,
                      style: sTextStyle(color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      list[index].body!,
                      style: sTextStyle(color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    } else {
      return AnimLoad(animG: animG);
    }
  });
  }

 
 
}



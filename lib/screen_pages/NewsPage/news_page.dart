
import 'package:flutter/material.dart';

import 'package:news/utils/const.dart';
import 'package:provider/provider.dart';

import '../../domain/Widgets/widgets.dart';
import '../../domain/providers/main_provider.dart';
import 'comments_page.dart';

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
        AnimationController(vsync: this, duration:const  Duration(seconds: 1));
    animG =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
            .animate(_controller);
    context.read<MainProvider>().loadPosts();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
      if (context.watch<MainProvider>().isLoaded['post'] ?? false) {
        return Container(
          color: const Color(0xff0F0C20),
          child: ListView(
            children: List.generate(
                context.watch<MainProvider>().listPosts.length, (index) {
              var list = context.watch<MainProvider>().listPosts;
              return InkWell(
                onTap: () {
                  provider.setIndexPost(list[index].id! - 1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const  CommentsPage(),
                    ),
                  );
                },
                child: Container(
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
                          style: sTextStyle(
                              color: Colors.white,
                              size: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      } else {
        return AnimLoad(
          animContainer(),
          animG: animG,
        );
      }
    });
  }

  ListView animContainer() {
    return ListView(
      children: List.generate(10, (index) {
        return Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xff221B44),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/domain/models/coments_model.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:news/main.dart';
import 'package:news/screenPages/NewsPage/five_comments.dart';
import 'package:provider/provider.dart';

import '../../domain/Widgets/widgets.dart';
import '../../utils/const.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animGradient;

  List<CommentsModel> listComments = [];
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animGradient =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
            .animate(_controller);
    context.read<MainProvider>().loadComments();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listPosts = context.watch<MainProvider>().listPosts;
    List<CommentsModel> listCommentsAll =
        context.watch<MainProvider>().listComments;
    listComments.clear();
    listCommentsAll.forEach((element) {
      if (element.postId == context.watch<MainProvider>().indexPost + 1) {
        listComments.add(element);
      }
    });

    return Consumer(builder: (context, provider, child) {
      if (context.watch<MainProvider>().isLoaded['comment'] ?? false) {
        return Scaffold(
          backgroundColor: const Color(0xff0F0C21),
          appBar: AppBar(
            backgroundColor: const Color(0xff221B44),
            title: Center(
              child: Text(
                cutTitle(
                    listPosts[context.watch<MainProvider>().indexPost].title!),
                style: sTextStyle(color: Colors.white, size: 22),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xff0F0C21),
                  child: Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            listPosts[context.watch<MainProvider>().indexPost]
                                .title!,
                            style: sTextStyle(color: Colors.white, size: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            listPosts[context.watch<MainProvider>().indexPost]
                                .body!,
                            style: sTextStyle(color: Colors.white, size: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: ListView(
                            children: List.generate(2, (index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xff221B44),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff232440),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Color(0xff96969B),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            listComments[index].name!,
                                            style: sTextStyle(
                                                color: Colors.white,
                                                size: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        listComments[index].body!,
                                        style: sTextStyle(
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiveCommentsPage(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff6C63FD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              'Show me',
                              style: sTextStyle(color: Colors.white, size: 18),
                            ),
                            Text(
                              '5 result',
                              style: sTextStyle(color: Colors.white, size: 18),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return Scaffold(
           backgroundColor: const Color(0xff0F0C21),
          appBar: AppBar(
            backgroundColor: const Color(0xff221B44),
            title: Center(
              child: Text(
                'Loading ...',
                style: sTextStyle(color: Colors.white, size: 22),
              ),
            ),
          ),
          body: AnimLoad(animContainer(), animG: animGradient),
        );
      }
    });
  }

  String cutTitle(String s) {
    String natija;
    if (s.length >= 18) {
      natija = '${s.substring(0, 18)}...';
    } else
      natija = s;
    return natija;
  }

  Column animContainer() {
    return Column(children: [
      const SizedBox(
        height: 30,
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ]);
  }
}

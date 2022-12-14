import 'package:flutter/material.dart';
import 'package:news/domain/models/coments_model.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/const.dart';

class FiveCommentsPage extends StatefulWidget {
  FiveCommentsPage(this.listComments,this.title, {Key? key}) : super(key: key);
  List<CommentsModel> listComments;
  String title;
  @override
  State<FiveCommentsPage> createState() => _FiveCommentsPageState();
}

class _FiveCommentsPageState extends State<FiveCommentsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animGradient;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animGradient = Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: const Color(0xff0F0C21),
        appBar: AppBar(
          backgroundColor: const Color(0xff221B44),
          title: Center(
            child: Text(
              cutTitle(widget.title),
              style: sTextStyle(color: Colors.white, size: 22),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff0F0C21),
          child: ListView(
            children: List.generate(5, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                            borderRadius: BorderRadius.circular(25),
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
                            widget.listComments[index].name!,
                            style: sTextStyle(color: Colors.white, size: 16, fontWeight: FontWeight.w500),
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
                        widget.listComments[index].body!,
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
      );
    });
  }

  String cutTitle(String s) {
    String natija;
    if (s.length >= 18) {
      natija = '${s.substring(0, 18)}...';
    } else {
      natija = s;
    }
    return natija;
  }
}

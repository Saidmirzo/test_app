import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/utils/const.dart';
import 'package:provider/provider.dart';

import '../../domain/Widgets/widgets.dart';
import '../../domain/providers/main_provider.dart';

class Checkpage extends StatefulWidget {
  const Checkpage({Key? key}) : super(key: key);

  @override
  State<Checkpage> createState() => _CheckpageState();
}

class _CheckpageState extends State<Checkpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animG;
  @override
  void initState() {
    super.initState();
    context.read<MainProvider>().loadCheck();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animG =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
            .animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      if (context.watch<MainProvider>().isLoaded['todos'] ?? false) {
        return Container(
          color: const Color(0xff0F0C21),
          child: ListView(
            children: List.generate(
                context.watch<MainProvider>().listCheck.length, (index) {
              var list = context.watch<MainProvider>().listCheck;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Checkbox(
                        value: list[index].completed ?? false,
                        onChanged: (context) {}),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        list[index].title!,
                        style: sTextStyle(
                          color: Colors.white,
                          size: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
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
      children: List.generate(11, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: const Color(0xff0F0C21),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid)),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 15,
                width: 200,
                color: Colors.white,
              )
            ],
          ),
        );
      }),
    );
  }
}

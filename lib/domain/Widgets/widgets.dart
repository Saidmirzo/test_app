import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimLoad extends StatelessWidget {
  const AnimLoad({
    Key? key,
    required this.animG,
  }) : super(key: key);

  final Animation<Alignment> animG;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Stack(
          children: [
            ListView(
              children: List.generate(10, (index) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff221B44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            AnimatedBuilder(
              animation: animG,
              builder: (context, child) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: animG.value,
                         
                          colors:const  [
                        Colors.transparent,
                        Color.fromRGBO(40, 33, 74, 0.8),
                        Colors.transparent
                      ])),
                );
              }
            )
          ],
        ),
      );
  }
}
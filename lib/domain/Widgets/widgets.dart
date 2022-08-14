import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimLoad extends StatelessWidget {
  AnimLoad(
    this._widget, {
    Key? key,
    required this.animG,
  }) : super(key: key);

  final Animation<Alignment> animG;
  late Widget _widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          _widget,
          AnimatedBuilder(
              animation: animG,
              builder: (context, child) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: animG.value,
                          colors: const [
                        Colors.transparent,
                        Color.fromRGBO(40, 33, 74, 0.8),
                        Colors.transparent
                      ])),
                );
              })
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/domain/providers/mainProvider.dart';
import 'package:provider/provider.dart';

import '../../domain/Widgets/widgets.dart';
import '../../utils/const.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animGradient;
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
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
     if (context.watch<MainProvider>().isLoaded['comment'] ?? false) {
      return Scaffold(

      );
    } else {
      return AnimLoad(animG: animGradient);
    }
  });
   
  }
}

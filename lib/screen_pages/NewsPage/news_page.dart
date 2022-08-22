import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/models/post_model.dart';

import 'package:news/utils/const.dart';

import '../../bloc/news/news_bloc.dart';
import '../../domain/Widgets/widgets.dart';
import '../../domain/providers/main_provider.dart';
import '../../main.dart';
import 'comments_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animG;
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(const NewsEventLoadPosts());

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animG = Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<NewsBloc>().add(const NewsEventLoadPosts());
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsStateComplatedLoadPosts) {
        List<PostsModel> list = state.listPosts;
        return Container(
          color: const Color(0xff0F0C20),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<NewsBloc>().add(const NewsEventLoadPosts());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    // notify();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(list[index].title!, list[index].body!, list[index].id!),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            style: sTextStyle(color: Colors.white, size: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      } else if (state is NewsStateFailed) {
        return Center(
          child: Text(
            'Connection error',
            style: sTextStyle(color: Colors.red, size: 20),
          ),
        );
      } else {
        return AnimLoad(animContainer(), animG: animG);
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

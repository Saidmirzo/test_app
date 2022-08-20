import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/models/alboms_model.dart';
import 'package:news/screen_pages/gallery_page/photos_page.dart';
import 'package:news/utils/const.dart';
import '../../bloc/gallery/gallery_bloc.dart';
import '../../domain/Widgets/widgets.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animG;
  @override
  void initState() {
    super.initState();

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
    var size = MediaQuery.of(context).size;
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is GalleryStateComplatedLoadPosts) {
          List<AlbomsModel> listAlboms = state.listAlboms;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: const Color(0xff0F0C20),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GalleryBloc>().add(const GalleryEventLoadAlboms());
              },
              child: GridView.count(
                physics:const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: size.height > 800
                    ? 1.11
                    : size.height > 700
                        ? 1.2
                        : 1.3,
                crossAxisCount: 2,
                children: List.generate(listAlboms.length, (index) {
                  return InkWell(
                    onTap: () {
                      //provider.setIndexGallery(list[index].id! - 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Photospage(listAlboms[index].title!),
                        ),
                      );
                    },
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffF44236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Expanded(
                            child: Text(
                          listAlboms[index].title!,
                          style: sTextStyle(color: Colors.white, size: 18),
                        ))),
                  );
                }),
              ),
            ),
          );
        } else {
          return AnimLoad(
            animContainer(),
            animG: animG,
          );
        }
      },
    );
  }

  Container animContainer() {
    return Container(
      color: const Color(0xff0F0C20),
      child: GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }),
      ),
    );
  }
}

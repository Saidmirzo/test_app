import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/gallery/bloc/photos_bloc.dart';
import 'package:news/bloc/gallery/gallery_bloc.dart';
import 'package:news/domain/models/photos_model.dart';
import 'package:news/utils/const.dart';

class Photospage extends StatefulWidget {
  Photospage(this.title, {Key? key}) : super(key: key);
  String title;
  @override
  State<Photospage> createState() => _PhotospageState();
}

class _PhotospageState extends State<Photospage> {
  @override
  void initState() {
    super.initState();
    context.read<PhotosBloc>().add( PhotosEventLoadPhotos());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        if (state is PhotosStateComplated) {
          List<PhotosModel> list = state.listPgotos;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff241F48),
              title: Text(
                widget.title,
                style: sTextStyle(
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            body: Container(
              color: const Color(0xff090617),
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: size.height > 800
                    ? 1.11
                    : size.height > 700
                        ? 1.2
                        : 1.3,
                crossAxisCount: 3,
                children: List.generate(list.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffB6B6B6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(list[index].url!),
                        fit: BoxFit.cover
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}

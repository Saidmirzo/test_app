import 'package:flutter/material.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:news/utils/const.dart';
import 'package:provider/provider.dart';

class Photospage extends StatefulWidget {
  const Photospage({Key? key}) : super(key: key);

  @override
  State<Photospage> createState() => _PhotospageState();
}

class _PhotospageState extends State<Photospage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff241F48),
          title: Text(
            context
                .watch<MainProvider>()
                .listGallery[context.watch<MainProvider>().indexGallery]
                .title!,
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
            children: List.generate(
                context.watch<MainProvider>().listGallery.length, (index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xffB6B6B6),
                  borderRadius: BorderRadius.circular(10),
                ),
                
              );
            }),
          ),
        ),
      );
    });
  }
}
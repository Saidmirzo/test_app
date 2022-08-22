import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:news/screen_pages/contacts_page/contacts_page.dart';
import 'package:news/utils/const.dart';

import '../bloc/check/check_bloc.dart';
import '../bloc/contacts/contact_bloc.dart';
import '../bloc/gallery/gallery_bloc.dart';
import '../bloc/news/news_bloc.dart';
import 'NewsPage/news_page.dart';
import 'check_page/check_page.dart';
import 'gallery_page/gallery_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controllerPage = PageController();
  late List<String> titleList = ['News', 'Gallery', 'Check', 'Contacts'];
  late String title;
 

  int indexNbar = 0;
  @override
  void initState() {
    super.initState();
    title = titleList[0];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff28214B),
            title: Center(
              child: Text(
                titleList[state.indexPage],
                style: sTextStyle(color: Colors.white, size: 22, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: sTextStyle(color: Colors.white),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: 'News',
                backgroundColor: Color(0xff322B54),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.class_,
                  color: Colors.white,
                ),
                label: 'Gallery',
                backgroundColor: Color(0xff322B54),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.heart_broken_sharp,
                  color: Colors.white,
                ),
                label: 'Check',
                backgroundColor: Color(0xff322B54),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: 'Contacts',
                backgroundColor: Color(0xff322B54),
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: state.indexPage,
            selectedItemColor: Colors.black,
            onTap: (index) {
              controllerPage.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              context.read<MainBloc>().add(MainEventSetIndexPage(index));
              title = titleList[index];
            },
            elevation: 5,
            iconSize: 30,
          ),
          body: PageView(
            onPageChanged: ((index) {
               context.read<MainBloc>().add(MainEventSetIndexPage(index));
              title = titleList[index];
            }),
            controller: controllerPage,
            children: const [
              NewsPage(),
              GalleryPage(),
              CheckPage(),
              ContactsPage(),
            ],
          ),
        );
      },
    );
  }
}

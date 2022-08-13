import 'package:flutter/material.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:news/screen_pages/contacts_page/contacts_page.dart';
import 'package:news/utils/const.dart';
import 'package:provider/provider.dart';

import 'NewsPage/news_page.dart';
import 'check_page/check_page.dart';
import 'gallery_page/gallery_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff28214B),
            title: Center(
              child: Text(
                context.watch<MainProvider>().titleAppBar,
                style: sTextStyle(
                    color: Colors.white, size: 22, fontWeight: FontWeight.w400),
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
            currentIndex: context.watch<MainProvider>().nBarIndex,
            selectedItemColor: Colors.black,
            onTap: (context) {
              provider.setNBarIndex(context);
              switch (context) {
                case 0:
                  provider.setTitleAppBar('News');
                  break;
                case 1:
                  provider.setTitleAppBar('Gallery');
                  break;
                case 2:
                  provider.setTitleAppBar('Check');
                  break;
                case 3:
                  provider.setTitleAppBar('Contacts');
                  break;

                default:
              }
            },
            elevation: 5,
            iconSize: 30,
          ),
          body: Builder(
            builder: (context) {
              if (context.watch<MainProvider>().nBarIndex <= 3) {
                switch (context.watch<MainProvider>().nBarIndex) {
                  case 0:
                    return const NewsPage();
                  case 1:
                    return const GalleryPage();
                  case 2:
                    return const CheckPage();
                  case 3:
                    return const ContactsPage();
                  default:
                }
              }
              return const NewsPage();
            },
          ),
        );
      },
    );
  }
}

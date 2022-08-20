import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screen_pages/contacts_page/person_about_page.dart';
import 'package:news/utils/const.dart';

import '../../bloc/contacts/contact_bloc.dart';
import '../../domain/Widgets/widgets.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> with SingleTickerProviderStateMixin {
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
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        if (state is ContactStateComplatedLoadPosts) {
          var list = state.listContacts;
          return Container(
            color: const Color(0xff0F0C21),
            child: RefreshIndicator(
              onRefresh: ()async {
                context.read<ContactBloc>().add(ContactEventLoadContact());
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  list.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        //provider.setIndexContact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonAboutPage(list, list[index].id! - 1),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Color(0xff949494),
                          ),
                          title: Text(
                            list[index].name!,
                            style: sTextStyle(color: Colors.white, size: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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

  ListView animContainer() {
    return ListView(
      children: List.generate(11, (index) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: const Color(0xff0F0C21),
            child: const ListTile(
              leading: Icon(Icons.person),
            ));
      }),
    );
  }
}

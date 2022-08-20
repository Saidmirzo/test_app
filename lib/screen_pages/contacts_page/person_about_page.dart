import 'package:flutter/material.dart';
import 'package:news/domain/models/users_model.dart';
import 'package:news/screen_pages/contacts_page/map_page.dart';
import 'package:news/utils/const.dart';

class PersonAboutPage extends StatefulWidget {
   PersonAboutPage(this.list, this.index,{Key? key}) : super(key: key);
  List<UsersModel> list;
  int index;
  @override
  State<PersonAboutPage> createState() => _PersonAboutPageState();
}

class _PersonAboutPageState extends State<PersonAboutPage> with TickerProviderStateMixin {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController webSiteController;
  late TextEditingController companyController;
  late TextEditingController adressController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    webSiteController = TextEditingController();
    companyController = TextEditingController();
    adressController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    webSiteController.dispose();
    companyController.dispose();
    adressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    var list = widget.list;
    emailController.text = list[index].email!;
    phoneController.text = list[index].phone!;
    webSiteController.text = list[index].website!;
    companyController.text = list[index].company!.name!;
    adressController.text = list[index].address!.street!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff241F48),
        title: Text(
          list[index].name!,
          style: sTextStyle(
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: const Color(0xff090617),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: const Color(0xff171A29),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xff969697),
                size: 32,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              list[index].name!,
              style: sTextStyle(color: Colors.white, size: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              list[index].email!,
              style: sTextStyle(color: const Color(0xff433799), size: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            listAbout(emailController, 'E-mail'),
            listAbout(phoneController, 'Phone number'),
            listAbout(webSiteController, 'Website'),
            listAbout(companyController, 'Company'),
            listAbout(adressController, 'Adress'),
            InkWell(
              onTap: () {
                openMaps(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 200,
                color: const Color(0xffDFE0DB),
                child: Text(
                  'Map without your lovation',
                  style: sTextStyle(color: Colors.black, size: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container listAbout(TextEditingController controller, String s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        style: sTextStyle(color: Colors.white, size: 18),
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: s,
          labelStyle: sTextStyle(
            color: const Color(0xff514D65),
          ),
        ),
        enabled: false,
      ),
    );
  }
}

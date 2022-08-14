import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:news/screen_pages/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'key1',
  //       channelName: 'name',
  //       channelDescription: 'test_app',
  //       defaultColor: const Color(0xff9050DD),
  //       ledColor: Colors.white,
  //       playSound: true,
  //       enableLights: true,
  //       enableVibration: true,
  //     ),
  //   ],
  // );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

// void notify() async{
//  await  AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 1,
//       channelKey: 'key1',
//       title: 'This is notification',
//       body: 'body',
//     ),
//   );
// }
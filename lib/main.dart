import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onboard/firebase_options.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';
import 'package:onboard/view/screens/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomeScreen(),
      // navigatorKey: kNavigatorKey,
      // initialRoute: AppPages.appEntry,
      // onGenerateRoute: CustomNavigator.controller,
    );
  }
}
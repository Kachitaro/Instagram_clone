import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mid/responsive/responsive_layout_sreen.dart';
import 'package:instagram_mid/screens/login_screen.dart';
import 'package:instagram_mid/screens/signup_screen.dart';
import 'package:instagram_mid/utils/colors.dart';
import 'package:instagram_mid/responsive/mobile_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Mid',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ReponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      home: SignupScreen(),
    );
  }
}

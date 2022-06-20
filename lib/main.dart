import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/navigation.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kwebBackgroundColor,
          ),
      onGenerateRoute: RoutesGenerator.generateRoute,
      home: const LoginScreen(),
      // home: ResponsiveLayout(
      //   MobileScreenLayout: MobileScreenLayout(),
      //   WebScreenLayout: WebScreenLayout(),
      // ),
    );
  }
}

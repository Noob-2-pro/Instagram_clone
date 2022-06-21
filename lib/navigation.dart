import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/reposnsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';

const String loginRoute = '/loginScreen';
const String signUpRoute = '/SignupScreen';
const String responsiveLayout = '/responsiveLayout';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) =>  HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case responsiveLayout:
        return MaterialPageRoute(
            builder: (_) =>
                const ResponsiveLayout(WebScreenLayout: WebScreenLayout(), MobileScreenLayout: MobileScreenLayout()));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

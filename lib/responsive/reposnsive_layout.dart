import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key, required this.WebScreenLayout, required this.MobileScreenLayout}) : super(key: key);

  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > kwebScreenSize) {
          return WebScreenLayout;
        } else{
          return MobileScreenLayout;
        }
      },
    );
  }
}

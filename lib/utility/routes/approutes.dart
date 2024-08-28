import 'package:assignmentjoyistick/utility/uihelper/allpackages.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) =>userName.isEmpty? Login():Home());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(
          builder: (_) =>  Scaffold(
            body: Center(
              child: UiHelper.subHeading(Appstring.pageNotFound,Colors.black),
            ),
          ),
        );
    }
  }
}

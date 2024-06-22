import 'package:flutter/material.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/screens/HomeScreen.dart';
import 'package:onboard/view/screens/loginScreen.dart';
import 'package:onboard/view/screens/signupScreen.dart';
import 'package:onboard/view/screens/splashScreen.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case AppPages.login:
        return MaterialPageRoute(
          builder: (context) => loginScreen(),
          settings: settings,
        );
      case AppPages.register:
        return MaterialPageRoute(
          builder: (context) => signupScreen(),
          settings: settings,
        );
      case AppPages.home:
        return MaterialPageRoute(
          builder: (context) => MyHomeScreen(),
          settings: settings,
        );

      default:
        throw ('This route name does not exit');
    }
  }

  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

// Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

// Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushNamedAndRemoveUntil(
      context,
      strPageName,
      (route) => false,
      arguments: arguments,
    );
  }
}

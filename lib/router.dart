
import 'package:flutter/material.dart';
import 'package:shopping_app/src/auth/ui/login_screen.dart';
import 'package:shopping_app/src/auth/ui/signup_screen.dart';
import 'package:shopping_app/src/home/ui/home_screen.dart';
import 'package:shopping_app/src/home/ui/splash_screen.dart';


class AppRouter {
  static const String splashRoute = "/";
  static const String homeRoute = "/home_route";
  static const String loginRoute = "/login_route";
  static const String signupRoute = "/signup_route";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashRoute:
      //   return MaterialPageRoute(
      //       settings: RouteSettings(name: "/welcome"),
      //       builder: (_) => WelcomeQrPage());

       case splashRoute:
        return MaterialPageRoute(builder: (_) => CustomSplash());

      case loginRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: "/login"),
            builder: (_) => LoginScreen());

      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen());

         case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

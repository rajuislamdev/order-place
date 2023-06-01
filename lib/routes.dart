import 'package:flutter/material.dart';
import 'package:place_order/view/screens/auth/login.dart';
import 'package:place_order/view/screens/auth/signup.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case signUp:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
    }
    return null;
  }
}

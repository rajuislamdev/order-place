import 'package:flutter/material.dart';
import 'package:place_order/model/cart_product.dart';
import 'package:place_order/model/product.dart';
import 'package:place_order/view/screens/auth/login.dart';
import 'package:place_order/view/screens/auth/signup.dart';
import 'package:place_order/view/screens/checkoout/checkout.dart';
import 'package:place_order/view/screens/dashboard/dashboard.dart';
import 'package:place_order/view/screens/product_details/product_details.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String dashboard = '/dashboard';
  static const String productDetails = '/productDetails';
  static const String checkout = '/checkout';

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
      case dashboard:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DashboardScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case productDetails:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProductDetailsScreen(
              products: settings.arguments as Products,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case checkout:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CheckoutScreen(
              cartProduct: settings.arguments as CartProduct,
            );
          },
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

import 'package:flutter/material.dart';
import 'package:omni_bridge_assignment/src/ui/screens/pets/add_pets.dart';
import '../ui/screens/authentication/registration_screen.dart';
import '../ui/screens/authentication/login_screen.dart';
import '../ui/screens/bottom_nav/bottom_nav.dart';
import 'page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final data = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case "/home":
        return SlideTransitionToRight(const BottomNavScreen());
      case "/login":
        return SlideTransitionToLeft(const LoginScreen());
      case "/register":
        return SlideTransitionToLeft(const RegistrationScreen());
      case "/add-pet":
        return SlideTransitionToRight(AddPetsScreen(
          ownerName: data?["owner_name"],
          ownerContact: data?["owner_contact"],
        ));
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
          body: Center(
        child: Text("Page not found"),
      ));
    });
  }
}

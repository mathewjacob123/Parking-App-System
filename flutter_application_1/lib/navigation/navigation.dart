import 'package:flutter/material.dart';
import '../registration_page.dart';
import '../screens/registration/user_registration.dart';
import '../screens/registration/owner_registration.dart';
import '../screens/login/login_page.dart';

class AppNavigation {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/registration': (context) =>  RegistrationPage(),
      '/user-registration': (context) =>  UserRegistrationPage(),
      '/owner-registration': (context) =>  OwnerRegistrationPage(),
      '/login': (context) =>  LoginPage(),
    };
  }
}

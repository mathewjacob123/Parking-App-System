import 'package:flutter/material.dart';
import 'navigation/navigation.dart';
import 'screens/registration/user_registration.dart';
import 'screens/registration/owner_registration.dart';
import 'screens/login/login_page.dart';
import 'registration_page.dart';
import 'welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      initialRoute: '/',  // You can define an initial route here
      routes: AppNavigation.getRoutes(),  // Use the routes from AppNavigation
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  WelcomePage(), // Define your initial screen here
    );
  }
}

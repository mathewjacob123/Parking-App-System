import 'package:flutter/material.dart';
import 'navigation/navigation.dart'; // Import the navigation file
import 'widgets/common_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Parking App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Using Navigator.pushNamed to go to registration page
            CommonButton(
              text: "Register",
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            // Using Navigator.pushNamed to go to login page
            CommonButton(
              text: "Login",
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

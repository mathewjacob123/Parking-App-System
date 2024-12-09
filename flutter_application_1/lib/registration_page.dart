import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common_button.dart'; // Import the common button
import 'screens/registration/user_registration.dart';
import 'screens/registration/owner_registration.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register as:",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            CommonButton(
              text: "User",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  UserRegistrationPage(),
                  ),
                );
              },
              backgroundColor: Colors.blue, // Customizable button color
              textColor: Colors.white,
            ),
            const SizedBox(height: 20),
            CommonButton(
              text: "Owner",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  OwnerRegistrationPage(),
                  ),
                );
              },
              backgroundColor: Colors.green, // Customizable button color
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

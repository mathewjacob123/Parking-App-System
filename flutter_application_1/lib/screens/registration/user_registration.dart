import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleNumberController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    const String url = 'http://192.168.0.111:8080/register'; // Replace with your backend endpoint

    final userData = {
      "username": _usernameController.text,
      "password": _passwordController.text,
      "email": _emailController.text,
      "phone": _phoneNumberController.text,
      "vehicle_type": _vehicleTypeController.text,
      "vehicle_number": _vehicleNumberController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("User registered: $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User registered successfully!")),
        );
      } else {
        print("Failed to register user: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to register user.")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains("@")) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(labelText: "Vehicle Type"),
              ),
              TextFormField(
                controller: _vehicleNumberController,
                decoration: InputDecoration(labelText: "Vehicle Number"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _registerUser(context);
                  }
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

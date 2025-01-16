import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OwnerRegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _parkingSpotsController = TextEditingController();

  String? _spaceType;

  Future<void> _registerOwner(BuildContext context) async {
    const String url = 'http://192.168.0.111:8080/register_owner'; // Replace with your backend endpoint

    final ownerData = {
      "name": _nameController.text,
      "password": _passwordController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "location": _locationController.text,
      "parking_spots": int.parse(_parkingSpotsController.text),
      "space_type": _spaceType,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(ownerData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Owner registered: $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Owner registered successfully!")),
        );

        // Clear the form
        _formKey.currentState?.reset();
        _nameController.clear();
        _passwordController.clear();
        _emailController.clear();
        _phoneController.clear();
        _locationController.clear();
        _parkingSpotsController.clear();
        _spaceType = null;
      } else {
        print("Failed to register owner: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to register owner.")),
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
      appBar: AppBar(title: const Text("Owner Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  if (value.length != 10) {
                    return "Phone number must be 10 digits";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              TextFormField(
                controller: _parkingSpotsController,
                decoration:
                    const InputDecoration(labelText: "Number of Parking Spots"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of parking spots";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Space Type"),
                items: ["Two_Wheeler", "Four_Wheeler"]
                    .map((type) => DropdownMenuItem(
                          value: type.toLowerCase().replaceAll(" ", "_"),
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  _spaceType = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a space type";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _registerOwner(context);
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

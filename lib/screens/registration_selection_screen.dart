import 'package:flutter/material.dart';
import 'parent_registration_screen.dart';
import 'driver_registration_screen.dart';
import 'login_screen.dart';

class RegistrationSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register As")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ParentRegistrationScreen()),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Register as Parent", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DriverRegistrationScreen()),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Register as Driver", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

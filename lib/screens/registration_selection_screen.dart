import 'package:flutter/material.dart';
import 'parent_registration_screen.dart';
import 'driver_registration_screen.dart';

class RegistrationSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register As", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRegisterBox(
              icon: Icons.person,
              label: 'Register as Parent',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ParentRegistrationScreen()),
              ),
            ),
            SizedBox(height: 20),
            _buildRegisterBox(
              icon: Icons.local_taxi,
              label: 'Register as Driver',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DriverRegistrationScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterBox({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 70, color: Colors.black),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black)
          ],
        ),
      ),
    );
  }
}

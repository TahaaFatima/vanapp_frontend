import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tabola-logo.png',
              fit: BoxFit.contain,
              height: 85,
            ),
            const SizedBox(width: 8),
            const Text('Login'),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _inputField(label: "Email", icon: Icons.mail),
              const SizedBox(height: 20),
              _inputField(label: "Password", icon: Icons.vpn_key),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 130),
                  child: Text('LOGIN', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({required String label, required IconData icon}) {
    return Material(
      elevation: 20,
      shadowColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(50),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),
          prefixIcon: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }
}

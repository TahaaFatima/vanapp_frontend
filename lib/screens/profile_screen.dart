import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final res = await http.get(Uri.parse('http://localhost:3000/api/user/${widget.userId}'));
    if (res.statusCode == 200) {
      setState(() {
        userData = jsonDecode(res.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
            ),
            const SizedBox(height: 20),
            const Text("Profile Information", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _infoTile("Email ID", userData!['email']),
            _infoTile("Phone", userData!['phone']),
            _infoTile("Role", userData!['role']),
            _infoTile("Created At", userData!['createdAt']),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return ExpansionTile(
      title: Text(title),
      children: [ListTile(title: Text(value))],
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'profile_screen.dart';
import 'drivers_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? userName; // <-- name or email to display

  final List<Widget> _screens = []; // populated in initState

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final res = await http.get(Uri.parse('${dotenv.env['BASE_URL']}/api/user/${widget.userId}'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        userName = data['email']; // or data['name'] if available
        _screens.addAll([
          Center(child: Text("Home Page")),
          DriversListingScreen(),
          Center(child: Text("Notifications")),
          ProfileScreen(userId: widget.userId),
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName == null ? "Loading..." : "Hello, $userName 👋"),
        centerTitle: true,
      ),
      body: _screens.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus_filled), label: "Drivers"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

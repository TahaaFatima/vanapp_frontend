import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'driver_detail_screen.dart';

class DriversListingScreen extends StatefulWidget {
  const DriversListingScreen({super.key});

  @override
  State<DriversListingScreen> createState() => _DriversListingScreenState();
}

class _DriversListingScreenState extends State<DriversListingScreen> {
  List<dynamic> drivers = [];

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    final res = await http.get(Uri.parse('http://localhost:3000/api/drivers'));
    if (res.statusCode == 200) {
      setState(() {
        drivers = jsonDecode(res.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: drivers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index];
                final user = driver['User'] ?? {};
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DriverDetailScreen(driver: driver),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/default_avatar.png'), // fallback
                      ),
                      title: Text(user['email'] ?? 'Driver Email'),
                      subtitle: Text("Reg#: ${driver['vehicleRegNumber'] ?? ''}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.call), onPressed: () {}),
                          IconButton(icon: Icon(Icons.message), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

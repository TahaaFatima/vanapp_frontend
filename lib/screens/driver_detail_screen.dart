import 'package:flutter/material.dart';

class DriverDetailScreen extends StatelessWidget {
  final Map<String, dynamic> driver;
  const DriverDetailScreen({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final user = driver['User'] ?? {};
    return Scaffold(
      appBar: AppBar(title: Text("Driver Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/default_avatar.png')),
            const SizedBox(height: 20),
            Text("Email: ${user['email'] ?? 'N/A'}"),
            Text("Phone: ${user['phone'] ?? 'N/A'}"),
            Text("Vehicle Reg#: ${driver['vehicleRegNumber'] ?? 'N/A'}"),
            Text("Vehicle Type: ${driver['vehicleType'] ?? 'N/A'}"),
            Text("Vehicle Capacity: ${driver['vehicleCapacity'] ?? 'N/A'}"),
            Text("License: ${driver['cnicOrLicensePath'] ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}

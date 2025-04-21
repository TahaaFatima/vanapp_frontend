  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;

  class DriverProfileScreen extends StatefulWidget {
    @override
    State<DriverProfileScreen> createState() => _DriverProfileScreenState();
  }

  class _DriverProfileScreenState extends State<DriverProfileScreen> {
    Map<String, String> profileData = {};
    bool isLoading = true;

    @override
    void initState() {
      super.initState();
      _fetchProfile();
    }

    Future<void> _fetchProfile() async {
      final uri = Uri.parse('http://10.0.2.2:3000/driver/profile/2'); 

      try {
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          setState(() {
            profileData = {
              'User Name': data['name']?.toString() ?? '',
              'Vehicle RegNumber Number': data['vehicleRegNumber']?.toString() ?? '',
              'Vehicle Type': data['vehicleType']?.toString() ?? '',
              'Vehicle Capacity': data['vehicleCapacity']?.toString() ?? '',
              'license Status': 'Approved',
              'Phone Number': data['phone']?.toString() ?? '',
              'Email ID': data['email']?.toString() ?? '',
            };
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load profile');
        }
      } catch (e) {
        print('Error: $e');
        setState(() => isLoading = false);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(height: 16),
                  _buildProfileAvatar(),
                  SizedBox(height: 16),
                  Text(
                    'Profile Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: profileData.length,
                      itemBuilder: (context, index) {
                        String key = profileData.keys.elementAt(index);
                        String value = profileData[key]!;
                        return _profileTile(title: key, subtitle: value);
                      },
                    ),
                  ),
                ],
              ),
      );
    }

  Widget _profileTile({required String title, required String subtitle}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black87, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.yellow[800],),
        ],
      ),
    );
  }

Widget _buildProfileAvatar() {
  String? imagePath = profileData['Profile'];
  if (imagePath != null && imagePath.isNotEmpty) {
    return CircleAvatar(
      radius: 50, 
      backgroundImage: NetworkImage('http://10.0.2.2:3000/' + imagePath),
    );
  } else {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/profile.png'),
    );
  }
}

  }

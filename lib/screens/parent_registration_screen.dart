import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ParentRegistrationScreen extends StatefulWidget {
  const ParentRegistrationScreen({super.key});

  @override
  State<ParentRegistrationScreen> createState() =>
      _ParentRegistrationScreenState();
}

class _ParentRegistrationScreenState extends State<ParentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<Map<String, String>> children = [];

  String? emergencyName;
  String? emergencyPhone;
  String? emergencyRelation;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _addChild() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameCtrl = TextEditingController();
        final TextEditingController gradeCtrl = TextEditingController();
        final TextEditingController genderCtrl = TextEditingController();
        final TextEditingController schoolCtrl = TextEditingController();

        return AlertDialog(
          title: const Text("Add Child"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameCtrl,
                    decoration:
                        const InputDecoration(labelText: "Child’s Name")),
                TextField(
                    controller: gradeCtrl,
                    decoration: const InputDecoration(labelText: "Grade")),
                TextField(
                    controller: genderCtrl,
                    decoration: const InputDecoration(labelText: "Gender")),
                TextField(
                    controller: schoolCtrl,
                    decoration:
                        const InputDecoration(labelText: "Child’s School")),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  children.add({
                    "name": nameCtrl.text,
                    "grade": gradeCtrl.text,
                    "gender": genderCtrl.text,
                    "school": schoolCtrl.text,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final uri = Uri.parse("http://10.0.2.2:3000/api/register/parent");

    var request = http.MultipartRequest('POST', uri);


    request.fields['fullName'] = fullNameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = phoneController.text;

    request.fields['emergencyName'] = emergencyName ?? '';
    request.fields['emergencyPhone'] = emergencyPhone ?? '';
    request.fields['emergencyRelation'] = emergencyRelation ?? '';

    // Hardcoded pickup coordinates (replace with map later)
    request.fields['pickupLat'] = '24.8607';
    request.fields['pickupLng'] = '67.0011';

    request.fields['children'] = jsonEncode(children);

    if (_profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profilePicture',
        _profileImage!.path,
      ));
    }

    final response = await request.send();
  print(response);
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registered Successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.statusCode}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFB800);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Registration"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputField("Full Name", fullNameController),
              _inputField("Email ", emailController),
              _inputField("Phone Number", phoneController),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _pickImage,
                child: Text(_profileImage == null
                    ? "Upload Profile Picture (Optional)"
                    : "Profile Selected"),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _addChild,
                icon: const Icon(Icons.add),
                label: const Text("Add Child"),
              ),
              const SizedBox(height: 10),

              if (children.isNotEmpty)
                Column(
                  children: children
                      .map((child) => ListTile(
                            leading: const Icon(Icons.child_care),
                            title: Text(child["name"] ?? ""),
                            subtitle: Text(
                                "${child["grade"]}, ${child["gender"]} - ${child["school"]}"),
                          ))
                      .toList(),
                ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Map integration later
                },
                child: const Text("Select Preferred Pickup Location"),
              ),

              const SizedBox(height: 20),
              const Divider(),
              const Text("Emergency Contact",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (val) => emergencyName = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                onChanged: (val) => emergencyPhone = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Relation"),
                onChanged: (val) => emergencyRelation = val,
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("FIND DRIVER",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DriverRegistrationScreen extends StatefulWidget {
  @override
  State<DriverRegistrationScreen> createState() => _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController           = TextEditingController();
  final TextEditingController emailController           = TextEditingController();
  final TextEditingController passwordController        = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController vehicleRegController      = TextEditingController();
  final TextEditingController vehicleTypeController     = TextEditingController();
  final TextEditingController vehicleCapacityController = TextEditingController();

  File? _profileImage;
  File? _cnicFile;
  final picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _profileImage = File(picked.path));
  }

  Future<void> _pickCnicFile() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _cnicFile = File(picked.path));
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final uri = Uri.parse('${dotenv.env['BASE_URL']}/api/register/driver');
    final request = http.MultipartRequest('POST', uri);

    request.fields['phone'] = phoneController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['vehicleRegNumber'] = vehicleRegController.text;
    request.fields['vehicleType'] = vehicleTypeController.text;
    request.fields['vehicleCapacity'] = vehicleCapacityController.text;

    if (_profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePicture', _profileImage!.path));
    }

    if (_cnicFile != null) {
      request.files.add(await http.MultipartFile.fromPath('cnicOrLicense', _cnicFile!.path));
    }

    try {
      final res = await request.send();
      final response = await http.Response.fromStream(res);

      if (res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Submitted for Approval')));
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${res.statusCode}')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connection failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: Text("Driver Registration")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _textField(label: "Phone Number", controller: phoneController),
              _textField(label: "Email", controller: emailController),
              _passwordField(label: "Password", controller: passwordController),
              _passwordField(label: "Confirm Password", controller: confirmPasswordController),
              SizedBox(height: 16),

              Text("Upload Profile Picture", style: labelStyle),
              ElevatedButton(onPressed: _pickProfileImage, child: Text(_profileImage == null ? "Choose Image" : "Image Selected")),

              SizedBox(height: 16),
              Text("Upload CNIC/License", style: labelStyle),
              ElevatedButton(onPressed: _pickCnicFile, child: Text(_cnicFile == null ? "Choose File" : "File Selected")),

              SizedBox(height: 24),
              _textField(label: "Vehicle Registration Number", controller: vehicleRegController),
              _textField(label: "Vehicle Type", controller: vehicleTypeController),
              _textField(label: "Vehicle Capacity", controller: vehicleCapacityController),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit for Approval"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _passwordField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }

}

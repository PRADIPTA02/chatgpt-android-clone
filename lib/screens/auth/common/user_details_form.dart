// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({super.key});

  @override
  _UserDialogState createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isMale = false;
  bool _isFemale = false;
  File _profileImagePath = File('/data/user/0/com.example.chatgpt/cache/8daa3174-c2fa-4154-9566-84d1c96cac11/myAvatar.png');

  Future _openImagePicker() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Details'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _openImagePicker,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImagePath!=null?FileImage(_profileImagePath):null,
                  child: _profileImagePath == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const Text('Gender', style: TextStyle(fontSize: 16)),
              CheckboxListTile(
                title: Text('Male'),
                value: _isMale,
                onChanged: (value) {
                  setState(() {
                    _isMale = value!;
                    _isFemale = false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Female'),
                value: _isFemale,
                onChanged: (value) {
                  setState(() {
                    _isFemale = value!;
                    _isMale = false;
                  });
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your age';
                  }
                  // Add additional age validation logic if needed
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your phone number';
                  }
                  // Add additional phone number validation logic if needed
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Perform actions with the user details
              // e.g., save to database or update state variables
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

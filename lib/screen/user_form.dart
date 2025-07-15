
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_async_cloud/model/user.dart';
import 'package:local_storage_async_cloud/provider/user_provider.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  const UserFormScreen({super.key});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Appointment')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                
                decoration: InputDecoration(labelText: 'User Nmae'),
                onSaved: (value) => name = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'email'),
                onSaved: (value) => email = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'phone number'),
                onSaved: (value) => phoneNo = value ?? '',
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 5, 156, 145), // Set the background color
                  foregroundColor: Colors.white, // Set the text color
                ),
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ref.read(userProvider.notifier).addUser(
                          User(
                            name: name,
                            email: email,
                            phoneNumber: phoneNo,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

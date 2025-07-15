import 'package:flutter/material.dart';

import '../model/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: ${user.name}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Company: ${user.email}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Description: ${user.phoneNumber}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
              ],
            ),
          ),
        
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'Muhammad Nur Hanif',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '123200123 / TPM IF-D',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

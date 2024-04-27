import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState(user: user);
}

class _HomeScreenState extends State
{
  late String _displayName = 'Loading...';
  final User user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _HomeScreenState({required this.user});

  @override
  void initState() {
    super.initState();
    // Fetch user's data from Firestore when the screen is initialized
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      // Retrieve user document from Firestore using user's UID
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      // Extract user's first name from the document
      String firstName = userDoc.get('firstName');
      // Extract user's last name from the document
      String lastName = userDoc.get('lastName');
      // Combine first name and last name to create display name
      setState(() {
        _displayName = '$firstName $lastName';
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome $_displayName!'), // Display user's name
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

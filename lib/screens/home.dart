import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(_firebaseAuth.currentUser!.email.toString()),
        actions: [
          IconButton(
            onPressed: () {
              _firebaseAuth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/auth', (route) => false);
            },
            icon: FaIcon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
      body: const Center(
        child: Text('You are logged in'),
      ),
    );
  }
}

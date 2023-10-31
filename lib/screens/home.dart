import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Local widgets and files:
import './profile/show_qr.dart';

final _firebaseAuth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> getUserData() async {
    print(
        "---------------------------------------------------------------------------------------------------");
    final user = _firebaseAuth.currentUser!;
    await user.reload();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // //set a delay of 1 second and execute the function
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   if (_firebaseAuth.currentUser!.displayName == null) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, '/register', (route) => false);
    //   }
    // });
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(_firebaseAuth.currentUser!.email.toString()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowQRCode(
                    dataString: _firebaseAuth.currentUser!.uid,
                  ),
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.qrcode,
              size: 20,
            ),
          ),
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
      body: Center(
        child: Text(_firebaseAuth.currentUser!.displayName.toString()),
      ),
    );
  }
}

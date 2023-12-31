import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

final _firebaseAuth = FirebaseAuth.instance;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _firstTime = true;
  String _email = '';
  final _emailController = TextEditingController();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: _email).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent.'),
          ),
        );
        // Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Try again.'),
          ),
        );
      }
    }
  }

  InputDecoration _textFieldDecoration(
      {required String labelText, int minLength = 0}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      ),
      labelText: labelText,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        //remove default back button
        automaticallyImplyLeading: false,
        //add a custom text button to the left of the appbar with the label back
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.primary, size: 15),
              Text(
                'Back',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/chatterly.png',
                  width: 150,
                ),
                const SizedBox(height: 10),
                Text(
                  'Password Reset',
                  style: GoogleFonts.neonderthaw(
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    // obscureText: true,
                    controller: _emailController,
                    validator: (value) => validateEmail(value, _firstTime),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    // onChanged: (_) => _formKey.currentState!.validate(),
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: _textFieldDecoration(labelText: 'Email'),
                  ),
                ),

                // Form fields for email and password, with outlinedborder
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _firstTime = false;
                    });
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text('Send Reset Email'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? value, bool firstTime) {
  if (!firstTime && (value == null || value.isEmpty)) {
    return 'Email is required';
  }
  const String regex_pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(regex_pattern);
  if (!firstTime && !regex.hasMatch(value!)) {
    return 'Invalid Email';
  }
  return null;
}

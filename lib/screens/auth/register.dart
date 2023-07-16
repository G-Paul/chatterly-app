import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Add logo from assets/images/chatterly.png
                Image.asset(
                  'assets/images/chatterly.png',
                  width: 100,
                ),
                SizedBox(height: 10),
                Text(
                  'Register',
                  style: GoogleFonts.neonderthaw(
                    fontSize: 48,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Center(
                    child: Text(
                      'please tell us a bit more about yourself',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.italiana(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: _textFieldDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: _textFieldDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      const String regex_pattern =
                          r'/^[.-)( ]*([0-9]{3})[.-)( ]*([0-9]{3})[.-)( ]*([0-9]{4})$/';
                      RegExp regex = RegExp(regex_pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Invalid Phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

final _firebaseAuth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwVerifyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _firstTime = true;
  String _email = '';
  String _password = '';
  String? _signUpState = null;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    setState(() {
      _signUpState = 'Signing up...';
    });
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) async {
        print(value);
        setState(() {
          _signUpState = "Success!! Redirecting to Sign In...";
        });
        await Future.delayed(const Duration(seconds: 2));
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, '/signin');
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _signUpState = "Error occurred!!!";
        // _signUpState = e.message;
      });
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "An error occured"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _signUpState = "Error occurred!!!";
      });
      print(e);
    } finally {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwVerifyController.dispose();
    super.dispose();
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

  @override
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
                  width: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign Up',
                  style: GoogleFonts.neonderthaw(
                    fontSize: 58,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // const SizedBox(height: 20),
                _signUpState == null
                    ? const SizedBox(height: 30)
                    : SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            _signUpState!,
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                //Text form fields to input email id and password
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    obscureText: true,
                    controller: _pwController,
                    validator: (value) => validatePassword(value, _firstTime),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    decoration: _textFieldDecoration(labelText: 'New Password'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    obscureText: true,
                    controller: _pwVerifyController,
                    validator: (value) => validateVerifyPassword(
                        value, _pwController.text, _firstTime),
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    // onSaved: (newValue) {
                    //   _password = newValue!;
                    // },
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    decoration:
                        _textFieldDecoration(labelText: 'Verify Password'),
                  ),
                ),
                // Form fields for email and password, with outlinedborder
                const SizedBox(height: 16),
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
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Have an account? Sign In'),
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

String? validatePassword(String? value, bool firstTime) {
  if (!firstTime && (value == null || value.isEmpty)) {
    return 'Pass is required';
  }
  if (!firstTime && value!.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? validateVerifyPassword(
    String? value, String? passwordToVerify, bool firstTime) {
  if (!firstTime && (value == null || value.isEmpty)) {
    return 'Pass is required';
  }
  if (!firstTime && value!.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (!firstTime && value != passwordToVerify) {
    return 'Passwords do not match';
  }
  return null;
}

import 'package:chatterly/screens/auth/loading.dart';
import 'package:chatterly/screens/auth/register.dart';
import 'package:chatterly/screens/auth/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Local packages and screens:
import 'package:chatterly/themes.dart';
import 'package:chatterly/screens/auth/auth.dart';

// Only for Routes:
import 'package:chatterly/screens/auth/signin.dart';
import 'package:chatterly/screens/auth/signup.dart';
import 'package:chatterly/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //only portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chatterly',
        theme: LightThemes.lightTheme,
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/signin': (context) => const SignInScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/pwreset': (context) => const ResetPasswordScreen(),
          '/home': (context) => const HomeScreen(),
        },
        home: FirebaseAuth.instance.currentUser == null
            ? const AuthScreen()
            : const HomeScreen());
  }
}

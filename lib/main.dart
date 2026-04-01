import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/LoginScreen.dart';
import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/LoginScreen2.dart';
import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/MainScreen.dart';
import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/SignupScreen.dart';
import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/main':    (context) => const MainScreen(),
        '/signup':  (context) => const SignupScreen(),
        '/login':   (context) => const LoginScreen2(),
        // '/details': (context) => const DetailsScreen(),
      },
    );
  }
}


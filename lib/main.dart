import 'package:busanit_401_k9_flutter_project/screen/basic2-miniproject/MainScreen.dart';
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
        // '/signup':  (context) => const SignupScreen(),
        // '/login':   (context) => const LoginScreen(),
        // '/details': (context) => const DetailsScreen(),
      },
    );
  }
}


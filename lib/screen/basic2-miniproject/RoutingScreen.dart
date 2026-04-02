import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DetailsScreen.dart';
import 'LoginScreen2.dart';
import 'MainScreen.dart';
import 'SignupScreen.dart';
import 'SplashScreen.dart';

class RoutingScreen extends StatelessWidget {
  const RoutingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/main':    (context) => const MainScreen(),
        '/signup':  (context) => const SignupScreen(),
        '/login':   (context) => const LoginScreen2(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}
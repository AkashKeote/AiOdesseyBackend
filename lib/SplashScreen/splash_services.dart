import 'dart:async';
import 'package:chatbot/DashBoard.dart';
import 'package:chatbot/main.dart' as main;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// In SplashServices.dart
class SplashServices {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;

    try {
      final user = auth.currentUser;
      await Future.delayed(Duration(seconds: 2));

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // Replace main.SilentMoonApp() with SilentMoonScreen()
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => main.SilentMoonScreen()),
        );
      }
    } catch (e) {
      print('Error checking login status: $e');
    }
  }
}
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatbot/SplashScreen/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashScreen = SplashServices();
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    splashScreen.isLogin(context);
    setState(() {
      _isLoading = false; // Update loading state after checking login
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loading indicator while checking login
            : AnimatedTextKit(
                repeatForever: false,
                animatedTexts: [
                  TyperAnimatedText(
                    "Splash Screen...",
                    textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
              ),
      ),
    );
  }
}
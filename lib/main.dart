import 'package:chatbot/LoginScreen.dart';
import 'package:chatbot/SignUpScreen.dart';
import 'package:chatbot/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(SilentMoonApp());
}

class SilentMoonApp extends StatelessWidget {
  const SilentMoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SilentMoonScreen(),
    );
  }
}

class SilentMoonScreen extends StatelessWidget {
  const SilentMoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Frame.png',
              fit: BoxFit.cover,
            ),
          ),

          // Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50), // Add top spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Silent',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Moon',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Image.asset(
                      'assets/images/Group.png',
                      width: 300,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'We are what we do',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Thousand of people are using Silent Moon for small meditations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ElevatedButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen()));},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6366F1),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey), // Default style
                        children: [
                          TextSpan(text: 'ALREADY HAVE AN ACCOUNT? '),
                          WidgetSpan(
                            alignment:
                                PlaceholderAlignment.middle, // Aligns with text
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(color: Color(0xFF6366F1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50), // Add bottom spacing
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

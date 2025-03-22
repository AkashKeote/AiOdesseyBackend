import 'package:chatbot/FocusScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = 'Guest';
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userData =
            await _firestore.collection('users').doc(user.uid).get();

        if (userData.exists) {
          setState(() {
            _userName = userData['username'] ?? 'User';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading user data';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash (1).png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S i l e n t ',
                          style: TextStyle(
                            fontFamily: 'airbnb',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(146, 255, 255, 255),
                          ),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          ' M  o o n',
                          style: TextStyle(
                            fontFamily: 'airbnb',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(146, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Column(
                        children: [
                          Text(
                            'Hi $_userName, Welcome',
                            style: TextStyle(
                              fontFamily: 'HelveticaMedium',
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFECCC),
                            ),
                          ),
                          Text(
                            'to Silent Moon',
                            style: TextStyle(
                              fontFamily: 'HelveticaLight',
                              fontSize: 35,
                              color: Color(0xFFFFECCC),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Explore the app, Find some peace of mind to prepare for meditation.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'HelveticaLight',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Focusscreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontFamily: 'HelveticaMedium',
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Positioned(
              bottom: 20,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

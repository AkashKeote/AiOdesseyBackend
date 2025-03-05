import 'package:flutter/material.dart';
import 'package:chatbot/FocusScreen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

    

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
              mainAxisAlignment:
                  MainAxisAlignment.start, // Start se start karega
              children: [
                SizedBox(height: 80), // Yeh text ko neeche karega
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          'Silent ',
                          
                          style: TextStyle(
                          fontFamily: 'AirbnbCerealApp',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          ),
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 30,
                        ),
                        Text(
                          ' Moon',
                          style: TextStyle(
                          fontFamily: 'AirbnbCerealApp',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'Hi Akash, Welcome',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'to Silent Moon',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30), // Center ke liye padding
                  child: Text(
                    'Explore the app, Find some peace of mind to prepare for meditation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(), // Button ko neeche push karega
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

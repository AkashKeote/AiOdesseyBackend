import 'package:chatbot/HappyMorningScreen.dart';
import 'package:chatbot/LoginScreen.dart';
import 'package:chatbot/MeditateDashBoard.dart';
import 'package:chatbot/SongScreen.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class Dashboard extends StatelessWidget {
  Dashboard({super.key});
 final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Silent',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Image.asset(
              'assets/images/logo.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 5),
            Text(
              'Moon',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning, Akash',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'We Wish you have a good day',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
             LayoutBuilder(
  builder: (context, constraints) {
    final cardWidth = constraints.maxWidth / 2 - 8; // Half width minus spacing
    final cardHeight = cardWidth * 1.2; // Maintain aspect ratio (original 176.43x210 = 1.19 ratio)

    return Row(
      children: [
        Expanded(
          child: _buildCourseCard(
            context,
            image: 'assets/images/12.png',
            title: 'Basics',
            subtitle: 'COURSE',
            buttonColor: Colors.white,
            textColor: Colors.black,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HappyMorningScreen())),
            height: cardHeight,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildCourseCard(
            context,
            image: 'assets/images/11.png',
            title: 'Relaxation',
            subtitle: 'MUSIC',
            buttonColor: Colors.black,
            textColor: Colors.white,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Meditatedashboard())),
            height: cardHeight,
          ),
        ),
      ],
    );
  },
),
              SizedBox(height: 20),
              _buildDailyThoughtCard(),
              SizedBox(height: 20),
              Text(
                'Recommended for you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildRecommendationsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    required Color buttonColor,
    required Color textColor,
    required VoidCallback onPressed,
    required double height,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
              LayoutBuilder(
  builder: (context, constraints) {
    if(constraints.maxWidth < 200) {
      return Row(
        children: [
          Expanded(
            child: Text(
              '3-10 MIN',
              style: TextStyle(color: textColor),
            ),
          ),
          SizedBox(width: 4),
          ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text('START', style: TextStyle(fontSize: 12)),
                  ),
        ],
      );
    }
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '3-10 MIN',
                    style: TextStyle(color: textColor),
                  ),
                  
                ],
              );
  },
)
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyThoughtCard() {
    return Card(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/13.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Thought',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'MEDITATION • 3-10 MIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                ),
                child: Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationsList() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRecommendationCard(
            imageUrl: 'https://storage.googleapis.com/a1aa/image/EMyw4MWvJD_qHUOXl8nE6rW66-RDInYpX8UI8gbNGP0.jpg',
            title: 'Focus',
            subtitle: 'MEDITATION • 3-10 MIN',
          ),
          _buildRecommendationCard(
            imageUrl: 'https://storage.googleapis.com/a1aa/image/ZUpTZUTULa2sSJ0lnPyrSELkgRONs2kDlBcEGDxL9IA.jpg',
            title: 'Happiness',
            subtitle: 'MEDITATION • 3-10 MIN',
          ),
          _buildRecommendationCard(
            imageUrl: 'https://storage.googleapis.com/a1aa/image/EMyw4MWvJD_qHUOXl8nE6rW66-RDInYpX8UI8gbNGP0.jpg',
            title: 'Focus',
            subtitle: 'MEDITATION • 3-10 MIN',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.blue,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.nightlight_round),
              color: Colors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.self_improvement),
              color: Colors.grey,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Meditatedashboard())),
            ),
            IconButton(
              icon: Icon(Icons.music_note),
              color: Colors.grey,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Songscreen())),
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.grey,
              onPressed: (){

                _auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }).onError((error, stackTrace) {
                  Utils().toastmessage(
                    error.toString()
                  );
                },);
              },
            ),
          ],
        ),
      ),
    );
  }
}
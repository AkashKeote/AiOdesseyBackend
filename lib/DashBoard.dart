import 'package:audioplayers/audioplayers.dart';
import 'package:chatbot/DarkMode1.dart';
import 'package:chatbot/HappyMorningScreen.dart';
import 'package:chatbot/MeditateDashBoard.dart';
import 'package:chatbot/SongScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.loop);
  String? _greeting;
  TimeOfDay? _selectedTime;
  List<bool>? _selectedDays;
  bool isPlaying = false; // Track play/pause state

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _audioPlayer.play(UrlSource(
            'https://drive.google.com/uc?export=download&id=1uMMJvIi6LCyrtUaUjWgkdB1w9nbRvfxg')); // Replace with your audio file URL
      } else {
        _audioPlayer.pause();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMeditationTime();
    _loadUserPreferences();
  }

  Future<void> _fetchMeditationTime() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot doc =
          await _firestore.collection('user_preferences').doc(user.uid).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final meditationTime = data['meditation_time'] as String;
        final parsedTime = _parseTime(meditationTime);
        _updateGreeting(parsedTime);
      }
    } catch (e) {
      print('Error fetching meditation time: $e');
    }
  }

  Future<void> _loadUserPreferences() async {
    final user = _auth.currentUser;
    if (user == null) {
      print("User is not logged in.");
      return;
    }

    try {
      DocumentSnapshot doc =
          await _firestore.collection('user_preferences').doc(user.uid).get();

      if (doc.exists) {
        print("Document found: ${doc.data()}");
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _selectedTime = _parseTime(data['meditation_time']);
          _selectedDays = List<bool>.from(data['selected_days']);
        });
      } else {
        print("Document does not exist.");
      }
    } catch (e) {
      print('Error loading preferences: $e');
    }
  }

  Future<void> _saveUserPreferences() async {
    final user = _auth.currentUser;
    if (user == null) {
      print("User is not logged in.");
      return;
    }

    try {
      await _firestore.collection('user_preferences').doc(user.uid).set({
        'meditation_time': _selectedTime
            ?.format(context), // Stores in 12-hour format like '11:30 AM'
        'selected_days': _selectedDays,
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print("User preferences saved successfully.");
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }

  TimeOfDay _parseTime(String time) {
    try {
      final parts = time.split(' '); // Separates time from AM/PM
      final timePart = parts[0]; // This will be '11:30'
      final period = parts[1]; // This will be 'AM' or 'PM'

      final timeParts = timePart.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      print('Error parsing time: $e');
      return TimeOfDay(hour: 0, minute: 0); // Default value in case of error
    }
  }

  void _updateGreeting(TimeOfDay time) {
    final hour = time.hour;
    if (hour >= 5 && hour < 12) {
      _greeting = 'Morning ';
    } else if (hour >= 12 && hour < 17) {
      _greeting = 'Afternoon';
    } else {
      _greeting = 'Evening ';
    }
    setState(() {});
  }

  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(timestamp.toDate());
  }

  String _getGreeting(int hour) {
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up resources
    super.dispose();
  }

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
              'S i l e n t ',
              style: TextStyle(
                fontFamily: 'airbnb',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(146, 0, 0, 0),
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
              ' M  o o n',
              style: TextStyle(
                fontFamily: 'airbnb',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(146, 19, 0, 0),
              ),
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final latestDoc = snapshot.data!.docs.first;
                  final message = latestDoc['message'];
                  final sender = latestDoc['sender'] ?? 'User';
                  final dayType = _greeting;

                  final timestamp = latestDoc['timestamp'] as Timestamp?;
                  final hour = timestamp?.toDate().hour ?? DateTime.now().hour;
                  String automaticGreeting = _getGreeting(hour);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good ${dayType ?? automaticGreeting}, $sender',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        message,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth / 2 - 8;
                  final cardHeight = cardWidth * 1.2;

                  return Row(
                    children: [
                      Expanded(
                        child: _buildCourseCard(
                          context,
                          image: 'assets/images/12.png',
                          title: 'Basics',
                          titleStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'HelveticaBold'),
                          subtitle: 'COURSE',
                          subtitleStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'HelveticaLight'),
                          buttonColor: Colors.white,
                          buttonStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'HelveticaMedium'),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HappyMorningScreen())),
                          height: cardHeight,
                          text: '3-10 MIN',
                          threemintextstyle: TextStyle(
                              color: const Color.fromARGB(255, 94, 86, 86)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildCourseCard(context,
                            image: 'assets/images/11.png',
                            title: 'Relaxation',
                            titleStyle: TextStyle(
                                color: const Color.fromARGB(255, 94, 86, 86),
                                fontSize: 20,
                                fontFamily: 'HelveticaBold'),
                            subtitle: 'MUSIC',
                            subtitleStyle: TextStyle(
                                color: const Color.fromARGB(255, 94, 86, 86),
                                fontSize: 16,
                                fontFamily: 'HelveticaLight'),
                            buttonColor: Colors.black,
                            buttonStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'HelveticaMedium'),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Meditatedashboard())),
                            height: cardHeight,
                            text: '5-30 MIN',
                            threemintextstyle: TextStyle(
                                color: const  Color.fromARGB(255, 94, 86, 86))),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              buildDailyThoughtCard(),
              SizedBox(height: 20),
              Text(
                'Recommended for you',
                style: TextStyle(fontSize: 18, fontFamily: 'HelveticaBold'),
              ),
              SizedBox(height: 10),
              _buildRecommendationsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required TextStyle threemintextstyle,
    required String text,
    required TextStyle buttonStyle,
    required String image,
    required String title,
    required TextStyle titleStyle,
    required String subtitle,
    required TextStyle subtitleStyle,
    required Color buttonColor,
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
                    style: titleStyle,
                  ),
                  Text(
                    subtitle,
                    style: subtitleStyle,
                  ),
                ],
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 200) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: Text('START', style: buttonStyle),
                        ),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '3-10 MIN',
                        style: threemintextstyle,
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

  Widget buildDailyThoughtCard() {
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
                          fontFamily: 'HelveticaBold'),
                    ),
                    Text(
                      'MEDITATION • 3-10 MIN',
                      style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'HelveticaLight'),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: 25,
                    // shadows: [
                    //   Shadow(
                    //     blurRadius: 100.0,
                    //     color: const Color.fromARGB(255, 15, 6, 6),
                    //     offset: Offset(0, 0),
                    //   ),
                    // ],
                  ),
                  onPressed: togglePlayPause,
                  iconSize: 33,
                ),
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
            imageUrl:
                'https://storage.googleapis.com/a1aa/image/EMyw4MWvJD_qHUOXl8nE6rW66-RDInYpX8UI8gbNGP0.jpg',
            title: 'Focus',
            subtitle: 'MEDITATION • 3-10 MIN',
          ),
          _buildRecommendationCard(
            imageUrl:
                'https://storage.googleapis.com/a1aa/image/ZUpTZUTULa2sSJ0lnPyrSELkgRONs2kDlBcEGDxL9IA.jpg',
            title: 'Happiness',
            subtitle: 'MEDITATION • 3-10 MIN',
          ),
          _buildRecommendationCard(
            imageUrl:
                'https://storage.googleapis.com/a1aa/image/EMyw4MWvJD_qHUOXl8nE6rW66-RDInYpX8UI8gbNGP0.jpg',
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

  Widget buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                decoration: BoxDecoration(
                 color: Color(0xFF8E97FD),
                  shape: BoxShape.circle,
                ),
              child: IconButton(
                icon: ImageIcon(AssetImage('assets/images/home.png')),
                 onPressed: () {},
              ),
            ),
            IconButton(
              icon: ImageIcon(AssetImage('assets/images/sleep.png')),
              color: Colors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: ImageIcon(AssetImage('assets/images/meditate.png')),
              color: Colors.grey,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Meditatedashboard())),
            ),
            IconButton(
              icon: ImageIcon(AssetImage('assets/images/music1.png')),
              color: Colors.grey,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Songscreen())),
            ),
            IconButton(
              icon: ImageIcon(AssetImage('assets/images/profile.png')),
              color: Colors.grey,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetStarted()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NightIslandScreen(),
    );
  }
}

class NightIslandScreen extends StatelessWidget {
  const NightIslandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.34;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/DM3.1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: imageHeight - 16),
                    // Content
                    Text(
                      'Night Island',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '45 MIN • SLEEP MUSIC',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ease the mind into a restful night’s sleep with these deep, ambient tones.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          '24,234 Favorites',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.headset, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          '34,234 Listening',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Related',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildImageContainer(
                                  'https://storage.googleapis.com/a1aa/image/dJSpsTSjB1OhUbw2CbqOMzVqOnoWWlxtgbebO84Yl_s.jpg'),
                              SizedBox(height: 8),
                              _buildTextContent('Moon Clouds'),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              _buildImageContainer(
                                  'https://storage.googleapis.com/a1aa/image/aOsWrztVdlHyGLYrxoaH8zpbOt4L1nydRy-TkVuGH10.jpg'),
                              SizedBox(height: 8),
                              _buildTextContent('Sweet Sleep'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8E97FD),
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'PLAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Full-screen DM3 Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/DM3.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: imageHeight,
            ),
          ),

          // Action Buttons
          Positioned(
            top: statusBarHeight + 16,
            left: 16,
            child: CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Container(
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: statusBarHeight + 16,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(92, 255, 255, 255),
                  radius: 25,
                  child: IconButton(
                    icon: Container(
                      child: Icon(Icons.favorite_border_outlined,
                          color: const Color.fromARGB(255, 32, 21, 21)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 12),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(113, 255, 255, 255),
                  child: IconButton(
                    icon: Container(
                      child: Icon(Icons.download_outlined,
                          color: const Color.fromARGB(255, 39, 15, 15)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon,
      {Color color = Colors.white, Color backgroundColor = Colors.white}) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: backgroundColor.withOpacity(0.3),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextContent(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '45 MIN • SLEEP MUSIC',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

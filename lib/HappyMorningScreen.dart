import 'package:audioplayers/audioplayers.dart'; // Add this import
import 'package:chatbot/DashBoard.dart';
import 'package:flutter/material.dart';

class HappyMorningScreen extends StatefulWidget {
  const HappyMorningScreen({super.key});

  @override
  _HappyMorningScreenState createState() => _HappyMorningScreenState();
}

class _HappyMorningScreenState extends State<HappyMorningScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.loop);
  bool isPlaying = false; // Track play/pause state
  String? currentUrl; // Track the current playing URL

  void togglePlayPause(String url) async {
    if (isPlaying && currentUrl == url) {
      await _audioPlayer.pause();
      print("Paused");
    } else {
      try {
        await _audioPlayer.setVolume(1.0); // Ensure volume is full
        await _audioPlayer.play(
          UrlSource(url),
          mode: PlayerMode.mediaPlayer, // Ensure media player mode
        );
        print("Playing...");
      } catch (e) {
        print("❌ Audio Player Error: $e");
      }
    }
    setState(() {
      isPlaying = !isPlaying;
      currentUrl = url;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Background Image Section (fixed)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 288.78,
              color: Colors.grey[300],
              child: Center(
                child: Image.asset("assets/images/16.png"),
              ),
            ),
          ),

          // Back Button (fixed)
          Positioned(
            top: 60,
            left: 16,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white.withOpacity(0.5),
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard())),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),

          // Action Buttons (fixed)
          Positioned(
            top: 60,
            right: 10,
            child: Row(
              children: [
                _buildActionButton(Icons.favorite),
                _buildActionButton(Icons.share),
                _buildActionButton(Icons.download),
              ],
            ),
          ),

          // Scrollable Content
          Positioned(
            top: 288.78, // Start below the image
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Happy Morning',
                      style: TextStyle(
                        fontFamily: 'airbnb',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'COURSE',
                      style: TextStyle(
                        fontFamily: 'HelveticaLight',
                        fontSize: 14,
                        color: const Color.fromARGB(255, 122, 116, 116),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ease the mind into a restful night’s sleep with these deep, ambient tones.',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'HelveticaLight',
                        fontSize: 16,
                        color: const Color.fromARGB(136, 95, 91, 91),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatsRow(),
                    const SizedBox(height: 16),
                    const Text(
                      'Pick a Narrator',
                      style: TextStyle(
                        fontFamily: 'HelveticaMedium',
                        fontSize: 18,
                        color: Color.fromARGB(151, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildNarratorButtons(),
                    const SizedBox(height: 16),
                    _buildAudioList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      onPressed: () {},
      child: Icon(icon, color: Colors.white),
    );
  }
  


  Widget _buildStatsRow() {
    return Row(
      children: [
        const Icon(Icons.favorite, color: Colors.pink),
        const SizedBox(width: 4),
        const Text('24,234 Favorites'),
        const SizedBox(width: 16),
        const Icon(Icons.headset, color: Colors.blue),
        const SizedBox(width: 4),
        const Text('34,234 Listening'),
      ],
    );
  }

  Widget _buildNarratorButtons() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'MALE VOICE',
            style: TextStyle(
              fontFamily: 'HelveticaMedium',
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'FEMALE VOICE',
            style: TextStyle(
                color: Colors.grey[600], fontFamily: 'HelveticaMedium'),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioList() {
    return Column(
      children: [
        _buildAudioItem(
            'Focus Attention', '10 MIN', 'https://drive.google.com/uc?export=download&id=1uMMJvIi6LCyrtUaUjWgkdB1w9nbRvfxg'),
        _buildAudioItem('Body Scan', '5 MIN', 'https://drive.google.com/uc?export=download&id=1t2ZOeB0ES_MqYx6qPGMmwOkjmLM5_1Xu'),
        _buildAudioItem(
            'Making Happiness', '3 MIN', 'https://drive.google.com/uc?export=download&id=1LzjsvIr57lnnKpNgNkDz-OD2-G4eno5-'),
           
      ],
    );
  }

  Widget _buildAudioItem(String title, String duration, String url) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF8E97FD),
              child: IconButton(
                icon: Icon(
                    isPlaying && currentUrl == url
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white),
                onPressed: () => togglePlayPause(url),
                iconSize: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'HelveticaMedium',
                  ),
                ),
                Text(
                  duration,
                  style: TextStyle(
                    fontFamily: 'HelveticaLight',
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 32),
      ],
    );
  }
  
}

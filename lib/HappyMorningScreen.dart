import 'package:chatbot/DashBoard.dart';
import 'package:flutter/material.dart';

class HappyMorningScreen extends StatelessWidget {
  const HappyMorningScreen({super.key});

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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard())),
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'COURSE',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ease the mind into a restful night’s sleep with these deep, ambient tones.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatsRow(),
                    const SizedBox(height: 16),
                    const Text(
                      'Pick a Narrator',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'FEMALE VOICE',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioList() {
    return Column(
      children: [
        _buildAudioItem('Focus Attention', '10 MIN'),
        _buildAudioItem('Body Scan', '5 MIN'),
        _buildAudioItem('Making Happiness', '3 MIN'),
      ],
    );
  }

  Widget _buildAudioItem(String title, String duration) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.play_arrow, color: Colors.white),
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
                  ),
                ),
                Text(
                  duration,
                  style: TextStyle(
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
import 'package:chatbot/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';

class HappyMorningScreen extends StatefulWidget {
  const HappyMorningScreen({super.key});

  @override
  _HappyMorningScreenState createState() => _HappyMorningScreenState();
}

class _HappyMorningScreenState extends State<HappyMorningScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
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
                    _buildFirestoreAudioList(),
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

  Widget _buildFirestoreAudioList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('songs')
          .orderBy('order') // Optional: Order by a field
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return CircularProgressIndicator();

        final songs = snapshot.data!.docs.map((doc) => Song.fromFirestore(doc)).toList();

        return Column(
          children: songs.map((song) => _buildAudioItem(song)).toList(),
        );
      },
    );
  }

  Widget _buildAudioItem(Song song) {
    return Column(
      children: [
        Row(
          children: [
            StreamBuilder<PlayerState>(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data?.playing ?? false;
                final currentUrl = (_audioPlayer.audioSource as UriAudioSource?)?.uri.toString();

                return IconButton(
                  icon: Icon(
                    (isPlaying && currentUrl == song.url)
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    if (isPlaying && currentUrl == song.url) {
                      _audioPlayer.pause();
                    } else {
                      _playSong(song.url);
                    }
                  },
                );
              },
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  song.duration,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 32),
      ],
    );
  }

  void _playSong(String url) async {
    try {
      await _audioPlayer.stop(); // Stop the previous song
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();

      // Update state to refresh UI
      setState(() {});
    } catch (e) {
      print('Error playing song: $e');
      // Show error dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text("Could not play the song"),
        ),
      );
    }
  }
}

class Song {
  final String title;
  final String duration;
  final String url;

  Song({required this.title, required this.duration, required this.url});

  factory Song.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Song(
      title: data['title'] ?? 'No Title',
      duration: data['duration'] ?? '0:00',
      url: data['url'] ?? '',
    );
  }
}
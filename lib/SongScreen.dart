import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Songscreen extends StatefulWidget {
  const Songscreen({super.key});

  @override
  _SongscreenState createState() => _SongscreenState();
}

class _SongscreenState extends State<Songscreen> {
  final AudioPlayer _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  bool isPlaying = false; // Track play/pause state

  void togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
      print("Paused");
    } else {
      try {
        await _audioPlayer.setVolume(1.0); // Ensure volume is full
        await _audioPlayer.play(
          UrlSource('https://drive.google.com/uc?export=download&id=1T6_p_xjif1CUnIQeGs9Ir9wFpi9SDZat'),
          mode: PlayerMode.mediaPlayer, // Ensure media player mode
        );
        print("Playing...");
      } catch (e) {
        print("❌ Audio Player Error: $e");
      }
    }
    setState(() {
      isPlaying = !isPlaying;
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/17.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Now Playing: Blinding Lights',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white),
                    onPressed: togglePlayPause,
                    iconSize: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

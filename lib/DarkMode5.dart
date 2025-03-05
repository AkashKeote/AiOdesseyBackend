import 'package:chatbot/DashBoard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Songscree(),
  ));
}

class Songscree extends StatefulWidget {
  const Songscree({super.key});

  @override
  _SongscreeState createState() => _SongscreeState(); // Fixed state class name
}

class _SongscreeState extends State<Songscree> {
  // Renamed state class
  bool isPlaying = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/DM5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.grey[600]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) => Dashboard())));
                          },
                          iconSize: 30,
                          padding: EdgeInsets.all(8),
                          constraints: BoxConstraints(),
                          splashRadius: 20,
                          tooltip: 'Close',
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 158, 158, 158)
                                  .withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.favorite_outline_outlined,
                                  color:
                                      const Color.fromARGB(255, 236, 229, 229)),
                              onPressed: () {},
                              iconSize: 30,
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(),
                              splashRadius: 20,
                              tooltip: 'Favorite',
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 158, 158, 158)
                                  .withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.download_outlined,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              onPressed: () {},
                              iconSize: 30,
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(),
                              splashRadius: 20,
                              tooltip: 'Download',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Night Island',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'SLEEP MUSIC',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(176, 245, 239, 239),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10,
                              color: const Color.fromARGB(248, 230, 225, 225)),
                          onPressed: () {},
                          iconSize: 30,
                          tooltip: 'Replay 10 seconds',
                        ),
                        SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(237, 253, 243, 243),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: const Color.fromARGB(185, 22, 9, 9)),
                            onPressed: togglePlayPause,
                            iconSize: 40,
                            tooltip: isPlaying ? 'Pause' : 'Play',
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.forward_10,
                              color: const Color.fromARGB(248, 230, 225, 225)),
                          onPressed: () {},
                          iconSize: 30,
                          tooltip: 'Forward 10 seconds',
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Slider(
                      value: 1.5,
                      min: 0,
                      max: 45,
                      onChanged: (value) {},
                      activeColor: const Color.fromARGB(255, 117, 164, 250),
                      inactiveColor: Colors.grey[300],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '01:30',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '45:00',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(SleepMusicApp());
}

class SleepMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SleepMusicScreen(),
    );
  }
}

class SleepMusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E21),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text('Sleep Music', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: List.generate(6, (index) {
            return SleepMusicCard(
              title: index % 2 == 0 ? 'Night Island' : 'Sweet Sleep',
              imageUrl: 'https://placehold.co/300x200',
              duration: '45 MIN',
              category: 'SLEEP MUSIC',
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1D1E33),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                icon: Icons.home,
                label: 'Home',
                onPressed: () {},
              ),
              NavigationBarItem(
                icon: Icons.nightlight_round,
                label: 'Sleep',
                onPressed: () {},
                isSelected: true,
              ),
              NavigationBarItem(
                icon: Icons.spa,
                label: 'Meditate',
                onPressed: () {},
              ),
              NavigationBarItem(
                icon: Icons.music_note,
                label: 'Music',
                onPressed: () {},
              ),
              NavigationBarItem(
                icon: Icons.person,
                label: 'Afsar',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  NavigationBarItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SleepMusicCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final String category;

  SleepMusicCard({
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$duration • $category',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
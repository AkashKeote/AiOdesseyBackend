import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(SleepStoriesApp());
}

class SleepStoriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SleepStoriesScreen(),
    );
  }
}

class SleepStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: FaIcon(
                  FontAwesomeIcons.moon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Sleep Stories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Soothing bedtime stories to help you fall into a deep and natural sleep',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryButton(icon: FontAwesomeIcons.thLarge, label: 'All', isSelected: true),
                  CategoryButton(icon: FontAwesomeIcons.heart, label: 'My'),
                  CategoryButton(icon: FontAwesomeIcons.frown, label: 'Anxious'),
                  CategoryButton(icon: FontAwesomeIcons.bed, label: 'Sleep'),
                  CategoryButton(icon: FontAwesomeIcons.child, label: 'Kids'),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    StoryCard(
                      imageUrl: 'https://placehold.co/600x300',
                      title: 'The Ocean Moon',
                      description: 'Non-stop 8-hour mixes of our most popular sleep audio',
                      buttonText: 'START',
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.network('https://placehold.co/300x200', fit: BoxFit.cover),
                              SizedBox(height: 8),
                              Text(
                                'Night Island',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '45 MIN • SLEEP MUSIC',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Image.network('https://placehold.co/300x200', fit: BoxFit.cover),
                              SizedBox(height: 8),
                              Text(
                                'Sweet Sleep',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '45 MIN • SLEEP MUSIC',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0A0E21),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.moon),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.spa),
            label: 'Meditate',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.music),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Afsar',
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  CategoryButton({required this.icon, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class StoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String? buttonText;

  StoryCard({required this.imageUrl, required this.title, required this.description, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                if (buttonText != null) ...[
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF0A0E21), backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(buttonText!),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
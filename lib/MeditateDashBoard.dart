import 'package:chatbot/DashBoard.dart';
import 'package:chatbot/SongScreen.dart';
import 'package:flutter/material.dart';

class Meditatedashboard extends StatelessWidget {
  const Meditatedashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Meditate',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'we can learn how to recognize when our minds are doing their normal everyday acrobatics.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton(Icons.grid_view, 'All', true),
                  _buildCategoryButton(Icons.favorite, 'My', false),
                  _buildCategoryButton(Icons.sentiment_dissatisfied, 'Anxious', false),
                  _buildCategoryButton(Icons.nightlight_round, 'Sleep', false),
                  _buildCategoryButton(Icons.child_care, 'Kids', false),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDailyCalmCard(),
                    SizedBox(height: 20),
                    _buildResponsiveGrid(
                      context,
                      firstImage: 'assets/images/18.png',
                      secondImage: 'assets/images/19.png',
                      firstHeightRatio: 210 / 176.43,
                      secondHeightRatio: 167 / 176.43,
                    ),
                    SizedBox(height: 20),
                    _buildResponsiveGrid(
                      context,
                      firstImage: 'assets/images/21.png',
                      secondImage: 'assets/images/20.png',
                      firstHeightRatio: 218.14 / 176.43,
                      secondHeightRatio: 210 / 176.43,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
  
      bottomNavigationBar: _buildBottomNavBar(context),
    );
    }
  }

  Widget _buildResponsiveGrid(BuildContext context, {
    required String firstImage,
    required String secondImage,
    required double firstHeightRatio,
    required double secondHeightRatio,
  }) {
    final screenWidth = MediaQuery.of(context).size.width - 32; // Account for padding
    final itemWidth = (screenWidth - 10) / 2; // Subtract spacing between items

    return Row(
      children: [
        _buildGridItem(
          width: itemWidth,
          height: itemWidth * firstHeightRatio,
          image: firstImage,
          title: '7 Days of Calm',
        ),
        SizedBox(width: 10),
        _buildGridItem(
          width: itemWidth,
          height: itemWidth * secondHeightRatio,
          image: secondImage,
          title: 'Anxiety Release',
        ),
      ],
    );
  }

  Widget _buildGridItem({
    required double width,
    required double height,
    required String image,
    required String title,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.blue[100] : Colors.grey[200],
            child: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey, 
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCalmCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/22.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Calm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'APR 30 • PAUSE PRACTICE',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.play_circle_fill, 
                color: Colors.white, 
                size: 40
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
  return BottomAppBar(
    color: Colors.white,
    child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            color: Colors.blue,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            ),
          ),
          
          IconButton(
            icon: const Icon(Icons.nightlight_round),
            color: Colors.grey,
            onPressed: () {},
          ),
          
          IconButton(
            icon: const Icon(Icons.self_improvement),
            color: Colors.grey,
            onPressed: () {}
          ),
          
          IconButton(
            icon: const Icon(Icons.music_note),
            color: Colors.grey,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Songscreen()),
            ),
          ),
          
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
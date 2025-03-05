import 'package:flutter/material.dart';
import 'package:chatbot/TimerScreen.dart';

class Focusscreen extends StatefulWidget {
  const Focusscreen({super.key});

  @override
  State<Focusscreen> createState() => _FocusscreenState();
}

class _FocusscreenState extends State<Focusscreen> {
  // Original Figma dimensions
  final double itemWidth = 176.43;
  final double largeHeight = 210;
  final double smallHeight = 167;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What Brings you',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'to Silent Moon?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final spacing = 16.0;
            
            // Calculate scale factor while maintaining original aspect ratios
            final scale = screenWidth < 400 ? (screenWidth - spacing * 3) / (itemWidth * 2) : 1.0;

            return Padding(
              padding: EdgeInsets.all(spacing),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'choose a topic to focus on:',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: spacing),
                    _buildResponsiveGrid(scale, spacing, context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveGrid(double scale, double spacing, BuildContext context) {
    return Column(
      children: [
        _buildResponsiveRow(
          firstImage: 'assets/images/1.png',
          secondImage: 'assets/images/2.png',
          firstHeight: largeHeight,
          secondHeight: smallHeight,
          scale: scale,
          spacing: spacing,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Timerscreen())),
        ),
        SizedBox(height: spacing),
        _buildResponsiveRow(
          firstImage: 'assets/images/3.png',
          secondImage: 'assets/images/4.png',
          firstHeight: smallHeight,
          secondHeight: largeHeight,
          scale: scale,
          spacing: spacing,
        ),
        SizedBox(height: spacing),
        _buildResponsiveRow(
          firstImage: 'assets/images/5.png',
          secondImage: 'assets/images/6.png',
          firstHeight: largeHeight,
          secondHeight: smallHeight,
          scale: scale,
          spacing: spacing,
        ),
        SizedBox(height: spacing),
        _buildResponsiveRow(
          firstImage: 'assets/images/7.png',
          secondImage: 'assets/images/8.png',
          firstHeight: largeHeight,
          secondHeight: largeHeight,
          scale: scale,
          spacing: spacing,
        ),
      ],
    );
  }

  Widget _buildResponsiveRow({
    required String firstImage,
    required String secondImage,
    required double firstHeight,
    required double secondHeight,
    required double scale,
    required double spacing,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        _buildGridItem(
          imagePath: firstImage,
          width: itemWidth * scale,
          height: firstHeight * scale,
          onTap: onTap,
        ),
        SizedBox(width: spacing),
        _buildGridItem(
          imagePath: secondImage,
          width: itemWidth * scale,
          height: secondHeight * scale,
        ),
      ],
    );
  }

  Widget _buildGridItem({
    required String imagePath,
    required double width,
    required double height,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
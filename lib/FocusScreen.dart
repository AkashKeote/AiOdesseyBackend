import 'package:flutter/material.dart';
import 'package:chatbot/TimerScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Focusscreen extends StatefulWidget {
  const Focusscreen({super.key});

  @override
  State<Focusscreen> createState() => _FocusscreenState();
}

class _FocusscreenState extends State<Focusscreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final double itemWidth = 176.43;
  final double largeHeight = 210;
  final double smallHeight = 167;
  bool _isLoading = true;
  String _errorMessage = '';

  // Firestore collection name
  final String _topicsCollection = 'meditation_topics';

  @override
  void initState() {
    super.initState();
    _checkUserPreferences();
  }

  Future<void> _checkUserPreferences() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('user_preferences').doc(user.uid).get();
        if (doc.exists && doc.data()?['last_selected_topic'] != null) {
          // Navigate directly if preference exists
          _navigateToTimer(doc.data()!['last_selected_topic']);
        }
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error loading preferences');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveUserPreference(String topic) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('user_preferences').doc(user.uid).set({
          'last_selected_topic': topic,
          'updated_at': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error saving preference: $e');
    }
  }

  void _navigateToTimer(String topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Timerscreen(selectedTopic: topic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final spacing = 16.0;
                    final scale = screenWidth < 400 ? (screenWidth - spacing * 3) / (itemWidth * 2) : 1.0;

                    return Padding(
                      padding: EdgeInsets.all(spacing),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection(_topicsCollection).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                          if (!snapshot.hasData) return CircularProgressIndicator();

                          final topics = snapshot.data!.docs;
                          return SingleChildScrollView(
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
                                _buildTopicsGrid(topics, scale, spacing),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildTopicsGrid(List<QueryDocumentSnapshot> topics, double scale, double spacing) {
    return Column(
      children: [
        for (int i = 0; i < topics.length; i += 2)
          Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: Row(
              children: [
                _buildTopicItem(topics[i], scale, spacing),
                if (i + 1 < topics.length) _buildTopicItem(topics[i + 1], scale, spacing),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTopicItem(QueryDocumentSnapshot topic, double scale, double spacing) {
    final data = topic.data() as Map<String, dynamic>;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _saveUserPreference(data['title']);
          _navigateToTimer(data['title']);
        },
        child: Container(
          margin: EdgeInsets.only(right: spacing),
          height: (data['isLarge'] ?? false) ? largeHeight * scale : smallHeight * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(data['image_url']),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
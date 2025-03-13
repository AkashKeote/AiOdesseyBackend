import 'package:chatbot/DashBoard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timerscreen extends StatefulWidget {
  const Timerscreen({super.key, required String selectedTopic});

  @override
  State<Timerscreen> createState() => _TimerscreenState();
}

class _TimerscreenState extends State<Timerscreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TimeOfDay _selectedTime = TimeOfDay(hour: 11, minute: 30);
  List<bool> _selectedDays = [true, true, true, true, false, false, false];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot doc = await _firestore
          .collection('user_preferences')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _selectedTime = _parseTime(data['meditation_time']);
          _selectedDays = List<bool>.from(data['selected_days']);
        });
      }
    } catch (e) {
      print('Error loading preferences: $e');
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  Future<void> _savePreferences() async {
    setState(() => _isLoading = true);
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore
          .collection('user_preferences')
          .doc(user.uid)
          .set({
            'meditation_time': _selectedTime.format(context),
            'selected_days': _selectedDays,
            'last_updated': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preferences saved successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving preferences: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: Duration(
                  hours: _selectedTime.hour,
                  minutes: _selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration newTime) {
                  setState(() {
                    _selectedTime = TimeOfDay(
                      hour: newTime.inHours,
                      minute: newTime.inMinutes.remainder(60),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What time would you like to meditate?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Any time you can choose but we recommend first thing in the morning.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                _buildTimePickerCard(),
                SizedBox(height: 32),
                _buildDaysSelector(),
                SizedBox(height: 32),
                _buildActionButtons(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerCard() {
    return GestureDetector(
      onTap: _showTimePicker,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                _selectedTime.format(context),
                key: ValueKey(_selectedTime),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap to change time',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which day would you like to meditate?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Every day is best, but we recommend picking at least five.',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(7, (index) {
            final days = ['SU', 'M', 'T', 'W', 'TH', 'F', 'S'];
            return ChoiceChip(
              label: Text(days[index]),
              selected: _selectedDays[index],
              onSelected: (selected) => setState(() => _selectedDays[index] = selected),
              selectedColor: Colors.black,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: _selectedDays[index] ? Colors.white : Colors.black,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : _savePreferences,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8E97FD),
            minimumSize: Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
        SizedBox(height: 6),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
          child: Text(
            'NO THANKS',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
import 'package:chatbot/DashBoard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timerscreen extends StatelessWidget {
  const Timerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerScreen1();
  }
}

class TimerScreen1 extends StatefulWidget {
  const TimerScreen1({super.key});

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<TimerScreen1> {
  TimeOfDay selectedTime = TimeOfDay(hour: 11, minute: 30);
  List<String> days = ['SU', 'M', 'T', 'W', 'TH', 'F', 'S'];
  List<bool> selectedDays = [true, true, true, true, false, false, false];

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
                  hours: selectedTime.hour,
                  minutes: selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration newTime) {
                  setState(() {
                    selectedTime = TimeOfDay(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What time would you like to meditate?',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'Any time you can choose but we recommend first thing in the morning.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                GestureDetector(
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
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: Text(
                            selectedTime.format(context),
                            key: ValueKey(selectedTime),
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap to change time',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Which day would you like to meditate?',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'Every day is best, but we recommend picking at least five.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(days.length, (index) {
                    return ChoiceChip(
                      label: Text(days[index]),
                      selected: selectedDays[index],
                      onSelected: (selected) {
                        setState(() {
                          selectedDays[index] = selected;
                        });
                      },
                      selectedColor: Colors.black,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                          color: selectedDays[index]
                              ? Colors.white
                              : Colors.black),
                    );
                  }),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8E97FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 6),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  child: Center(
                    child: Text(
                      'NO THANKS',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16), // Add extra space at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

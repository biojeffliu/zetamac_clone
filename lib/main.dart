import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _selectedDuration = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Zetamac Typing Test Setup')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Duration (in seconds):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: _selectedDuration,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedDuration = newValue ?? 60;
                });
              },
              items: <int>[30, 60, 120, 300, 600]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value seconds'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TypingTestScreen(
                        duration: _selectedDuration,
                      ),
                    ),
                  );
                },
                child: const Text('Start Typing Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypingTestScreen extends StatelessWidget {
  final int duration;

  TypingTestScreen({required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Typing Test"),
      ),
      body: Center(
        child: Text(
          'Typing test for $duration seconds.',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  bool isCheckedAddition = true;
  bool isCheckedSubtraction = true;
  bool isCheckedMultiplication = true;
  bool isCheckedDivision = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Text(
          '$isCheckedAddition Page',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SetupScreen(), // Default screen to show on app startup
    );
  }
}

void main() {
  runApp(const MyApp());
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final TextEditingController lowerBound1Addition = TextEditingController();
  final TextEditingController upperBound1Addition = TextEditingController();
  final TextEditingController lowerBound2Addition = TextEditingController();
  final TextEditingController upperBound2Addition = TextEditingController();

  final TextEditingController lowerBound1Multiplication = TextEditingController();
  final TextEditingController upperBound1Multiplication = TextEditingController();
  final TextEditingController lowerBound2Multiplication = TextEditingController();
  final TextEditingController upperBound2Multiplication = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial default values
    lowerBound1Addition.text = "2";
    upperBound1Addition.text = "100";
    lowerBound2Addition.text = "2";
    upperBound2Addition.text = "100";
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) return 'Enter a number';
    final intValue = int.tryParse(value);
    if (intValue == null || intValue < 2 || intValue > 100) {
      return 'Number must be between 2 and 100';
    }
    return null;
  }

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
        child: Column(
          children: [
            const Text(
              "Zetamac Arithmetic Game",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedAddition,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedAddition = value ?? false;
                    });
                  }
                ),
                const Text("Addition"),
              ],
            ),
          if (isCheckedAddition)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bounds for Addition"),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound1Addition,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 1",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: upperBound1Addition,
                          decoration: const InputDecoration(
                            labelText: "Upper Bound 1",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound2Addition,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: upperBound2Addition,
                          decoration: const InputDecoration(
                            labelText: "Upper Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedSubtraction,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedSubtraction = value ?? false;
                    });
                  }
                ),
                const Text("Subtraction"),
              ],
            ),
            if (isCheckedSubtraction)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Addition problems in reverse.")
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedMultiplication,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedMultiplication = value ?? false;
                    });
                  }
                ),
                const Text("Multiplication"),
              ],
            ),
            if (isCheckedMultiplication)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bounds for Multiplication"),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound1Multiplication,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 1",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: upperBound1Multiplication,
                          decoration: const InputDecoration(
                            labelText: "Upper Bound 1",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound2Multiplication,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: upperBound2Multiplication,
                          decoration: const InputDecoration(
                            labelText: "Upper Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: validateNumber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedDivision,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedDivision = value ?? false;
                    });
                  }
                ),
                const Text("Division"),
              ],
            ),
            if (isCheckedDivision)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Division problems in reverse.")
                ],
              ),
            ),
          ],
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

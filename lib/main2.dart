import 'dart:ffi';

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
        title: const Text("Typing test."),
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
class ArithmeticSettings extends StatefulWidget {
  const ArithmeticSettings({super.key});

  @override
  State<ArithmeticSettings> createState() => _ArithmeticSettings();
}

class _ArithmeticSettings extends State<ArithmeticSettings> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Arithmetic Setup')),
      ),
      body: Column(
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
                },
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
                  const Text("Bounds for Addition:"),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), 
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound2Addition,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        Row(children: [
          Checkbox(
                value: isCheckedSubtraction,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedSubtraction = value ?? false;
                  });
                },
              ),
              const Text("Subtraction"),
          ]
        ),
        if (isCheckedSubtraction)
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Addition problems in reverse.")
              ],)
          ),
        Row(children: [
          Checkbox(
                value: isCheckedMultiplication,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedMultiplication = value ?? false;
                  });
                },
              ),
              const Text("Multiplication"),
          ]
        ),
        if (isCheckedMultiplication)
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bounds for Multiplication:"),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), 
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lowerBound2Multiplication,
                          decoration: const InputDecoration(
                            labelText: "Lower Bound 2",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        Row(children: [
          Checkbox(
                value: isCheckedDivision,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedDivision = value ?? false;
                  });
                },
              ),
              const Text("Division"),
          ]
        ),
        if (isCheckedMultiplication)
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Multiplication problems in reverse.")
              ],)
          ),
        ],
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Center(
//         child: Column(
//           children: [
//             ArithmeticSettings(),
//             SetupScreen(),
//           ],
//         ),
//       )
//     );
//   }
// }

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

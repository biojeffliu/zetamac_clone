import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';


class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _selectedDuration = 120;
  bool isCheckedAddition = true;
  bool isCheckedSubtraction = true;
  bool isCheckedMultiplication = true;
  bool isCheckedDivision = true;

  String lowerBound1Addition = "2";
  String upperBound1Addition = "100";
  String lowerBound2Addition = "2";
  String upperBound2Addition = "100";
  String lowerBound1Multiplication = "2";
  String upperBound1Multiplication = "12";
  String lowerBound2Multiplication = "2";
  String upperBound2Multiplication = "100";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Zetamac Typing Test Setup')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen())
              );
              if (result != null) {
                setState(() {
                  isCheckedAddition = result['isCheckedAddition'];
                  isCheckedSubtraction = result['isCheckedSubtraction'];
                  isCheckedMultiplication = result['isCheckedMultiplication'];
                  isCheckedDivision = result['isCheckedDivision'];
                  lowerBound1Addition = result['lowerBound1Addition'];
                  upperBound1Addition = result['upperBound1Addition'];
                  lowerBound2Addition = result['lowerBound2Addition'];
                  upperBound2Addition = result['upperBound2Addition'];
                  lowerBound1Multiplication = result['lowerBound1Multiplication'];
                  upperBound1Multiplication = result['upperBound1Multiplication'];
                  lowerBound2Multiplication = result['lowerBound2Multiplication'];
                  upperBound2Multiplication = result['upperBound2Multiplication'];
                });
              }
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
                      builder: (context) => ArithmeticTestScreen(
                        duration: _selectedDuration,
                        isCheckedAddition: isCheckedAddition,
                        isCheckedSubtraction: isCheckedSubtraction,
                        isCheckedMultiplication: isCheckedMultiplication,
                        isCheckedDivision: isCheckedDivision,
                        lowerBound1Addition: lowerBound1Addition,
                        upperBound1Addition: upperBound1Addition,
                        lowerBound2Addition: lowerBound2Addition,
                        upperBound2Addition: upperBound2Addition,
                        lowerBound1Multiplication: lowerBound1Multiplication,
                        upperBound1Multiplication: upperBound1Multiplication,
                        lowerBound2Multiplication: lowerBound2Multiplication,
                        upperBound2Multiplication: upperBound2Multiplication,
                      ),
                    ),
                  );
                },
                child: const Text('Start Zetamac Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArithmeticTestScreen extends StatefulWidget {
  final int duration;
  final bool isCheckedAddition;
  final bool isCheckedSubtraction;
  final bool isCheckedMultiplication;
  final bool isCheckedDivision;
  final String lowerBound1Addition;
  final String upperBound1Addition;
  final String lowerBound2Addition;
  final String upperBound2Addition;
  final String lowerBound1Multiplication;
  final String upperBound1Multiplication;
  final String lowerBound2Multiplication;
  final String upperBound2Multiplication;

  const ArithmeticTestScreen({super.key,
    required this.duration,
    required this.isCheckedAddition,
    required this.isCheckedSubtraction,
    required this.isCheckedMultiplication,
    required this.isCheckedDivision,
    required this.lowerBound1Addition,
    required this.upperBound1Addition,
    required this.lowerBound2Addition,
    required this.upperBound2Addition,
    required this.lowerBound1Multiplication,
    required this.upperBound1Multiplication,
    required this.lowerBound2Multiplication,
    required this.upperBound2Multiplication,
  });

  @override
  _ArithmeticTestScreenState createState() => _ArithmeticTestScreenState();
}

class _ArithmeticTestScreenState extends State<ArithmeticTestScreen> {
  LinkedHashMap<String, int> problemsToSolutions = LinkedHashMap<String, int>();
  TextEditingController _controller = TextEditingController();
  String? currentProblem;
  int? currentSolution;
  int problemsSolved = 0;

  @override
  void initState() {
    super.initState();
    problemsToSolutions = generateArithmetic(
      isCheckedAddition: widget.isCheckedAddition,
      isCheckedSubtraction: widget.isCheckedSubtraction,
      isCheckedMultiplication: widget.isCheckedMultiplication,
      isCheckedDivision: widget.isCheckedDivision,
      lowerBound1Addition: int.parse(widget.lowerBound1Addition),
      upperBound1Addition: int.parse(widget.upperBound1Addition),
      lowerBound2Addition: int.parse(widget.lowerBound2Addition),
      upperBound2Addition: int.parse(widget.upperBound2Addition),
      lowerBound1Multiplication: int.parse(widget.lowerBound1Multiplication),
      upperBound1Multiplication: int.parse(widget.upperBound1Multiplication),
      lowerBound2Multiplication: int.parse(widget.lowerBound2Multiplication),
      upperBound2Multiplication: int.parse(widget.upperBound2Multiplication),
      numProblems: 1000,
    );
  }

  LinkedHashMap<String, int> generateArithmetic({
    required bool isCheckedAddition,
    required bool isCheckedSubtraction,
    required bool isCheckedMultiplication,
    required bool isCheckedDivision,
    required int lowerBound1Addition,
    required int upperBound1Addition,
    required int lowerBound2Addition,
    required int upperBound2Addition,
    required int lowerBound1Multiplication,
    required int upperBound1Multiplication,
    required int lowerBound2Multiplication,
    required int upperBound2Multiplication,
    required int numProblems,
  }) {
    // LinkedHashMap<String, int> problemsToSolutions = LinkedHashMap<String, int>();
    Random random = Random();

    while (problemsToSolutions.length < numProblems) {
      String operation = _getRandomOperation(
        isCheckedAddition,
        isCheckedSubtraction,
        isCheckedMultiplication,
        isCheckedDivision,
      );
      int num1 = 0;
      int num2 = 0;
      int solution = 0;
      if (operation == '+') {
        num1 = _randomBetween(random, lowerBound1Addition, upperBound1Addition);
        num2 = _randomBetween(random, lowerBound2Addition, upperBound2Addition);
        solution = num1 + num2;
      } else if (operation == '-') {
        num1 = _randomBetween(random, lowerBound1Addition, upperBound1Addition);
        num2 = _randomBetween(random, lowerBound2Addition, upperBound2Addition);
        solution = num1 - num2;
      } else if (operation == '*') {
        num1 = _randomBetween(random, lowerBound1Multiplication, upperBound1Multiplication);
        num2 = _randomBetween(random, lowerBound2Multiplication, upperBound2Multiplication);
        solution = num1 * num2;
      } else if (operation == '/') {
        num2 = _randomBetween(random, lowerBound1Multiplication, upperBound1Multiplication);
        num1 = _randomBetween(random, lowerBound2Multiplication, upperBound2Multiplication);
        if (num2 == 0) {
          continue; // Skip division by zero
        }
        solution = (num2 / num1).floor();
      }
      problemsToSolutions['$num1 $operation $num2 = ?'] = solution;
    }
    return problemsToSolutions;
  }

  int _randomBetween(Random random, int lower, int upper) {
    return lower + random.nextInt(upper - lower + 1);
  }

  String _getRandomOperation(bool addition, bool subtraction, bool multiplication, bool division) {
    List<String> operations = [];
    if (addition) operations.add('+');
    if (subtraction) operations.add('-');
    if (multiplication) operations.add('*');
    if (division) operations.add('/');
    return operations[Random().nextInt(operations.length)];
  }

  String _getCurrentProblem(LinkedHashMap<String, int> problemsToSolutions, int problemsSolved) {
    List<String> keys = problemsToSolutions.keys.toList();
    if (problemsSolved < keys.length) {
      return keys[problemsSolved];
    } else {
      return "Bro you solved all the problems generated that's crazy.";
    }
  }

  int _getCurrentSolution(LinkedHashMap<String, int> problemsToSolutions, int problemsSolved) {
    List<int> values = problemsToSolutions.values.toList();
    if (problemsSolved < values.length) {
      return values[problemsSolved];
    } else {
      return -1;
    }
  }

  Widget screenKeyPad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Score: $problemsSolved",
          style: TextStyle(fontSize: 24),
        ),
        Text(
          _getCurrentProblem(problemsToSolutions, problemsSolved),
          style: TextStyle(fontSize: 24),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            readOnly: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.none,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 300,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2, 
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                  if (index == 9) return Container();
                  if (index == 11) {
                    return _keypadButton('DEL', Colors.red); 
                  }
                  String value = index == 10 ? '0' : (index + 1).toString();
                  return _keypadButton(value, Colors.blue);
                },
            ),
          ),
        ),
      ],
    );
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'DEL') {
        if (_controller.text.isNotEmpty) {
          _controller.text = _controller.text.substring(0, _controller.text.length - 1);
        }
      } else {
        _controller.text += value;
        int enteredSolution = int.tryParse(_controller.text) ?? -1;
        int solution = _getCurrentSolution(problemsToSolutions, problemsSolved);
        if (enteredSolution == solution) {
          problemsSolved += 1;
          _controller.clear();
        }
      }
    });
  }
  
  Widget _keypadButton(String value, Color color) {
    return GestureDetector(
      onTap: () => _onKeyTap(value),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arithmetic Test"),
      ),
      body: Center(
        child: screenKeyPad(),
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
    lowerBound1Addition.text = "2";
    upperBound1Addition.text = "100";
    lowerBound2Addition.text = "2";
    upperBound2Addition.text = "100";
    lowerBound1Multiplication.text = "2";
    upperBound1Multiplication.text = "12";
    lowerBound2Multiplication.text = "2";
    upperBound2Multiplication.text = "100";
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) return 'Enter a number';
    final intValue = int.tryParse(value);
    if (intValue == null || intValue < 2 || intValue > 100) {
      return 'Number must be between 2 and 100';
    }
    return null;
  }

  TextFormField getFormField(TextEditingController controller) {
    return TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: validateNumber,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Map<String, dynamic> settingsData = {
              'isCheckedAddition': isCheckedAddition,
              'isCheckedSubtraction': isCheckedSubtraction,
              'isCheckedMultiplication': isCheckedMultiplication,
              'isCheckedDivision': isCheckedDivision,
              'lowerBound1Addition': lowerBound1Addition.text,
              'upperBound1Addition': upperBound1Addition.text,
              'lowerBound2Addition': lowerBound2Addition.text,
              'upperBound2Addition': upperBound2Addition.text,
              'lowerBound1Multiplication': lowerBound1Multiplication.text,
              'upperBound1Multiplication': upperBound1Multiplication.text,
              'lowerBound2Multiplication': lowerBound2Multiplication.text,
              'upperBound2Multiplication': upperBound2Multiplication.text,
            };

            Navigator.pop(context, settingsData); 
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
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
                        child: getFormField(lowerBound1Addition),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(upperBound1Addition),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(lowerBound2Addition),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(upperBound2Addition),
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
                        child: getFormField(lowerBound1Multiplication),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(upperBound1Multiplication),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(lowerBound2Multiplication),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: getFormField(upperBound2Multiplication),
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
      home: SetupScreen(),
    );
  }
}

void main() {
  runApp(const MyApp());
}

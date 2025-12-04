import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samsung Style Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Samsung Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = '0';  // Output of the calculation
  double _firstNum = 0;  // First operand
  String _operator = ''; // Operator (+, -, *, /)

  // Handle button presses
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0'; // Clear screen
        _firstNum = 0;
        _operator = '';
      } else if (value == '=') {
        double secondNum = double.tryParse(_output) ?? 0;
        switch (_operator) {
          case '+':
            _output = (_firstNum + secondNum).toString();
            break;
          case '-':
            _output = (_firstNum - secondNum).toString();
            break;
          case '*':
            _output = (_firstNum * secondNum).toString();
            break;
          case '/':
            if (secondNum != 0) {
              _output = (_firstNum / secondNum).toString();
            } else {
              _output = 'Error'; // Handle division by zero
            }
            break;
          default:
            break;
        }
        _operator = '';  // Clear operator after calculation
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _firstNum = double.tryParse(_output) ?? 0;
        _operator = value;
        _output = '0'; // Prepare for next number input
      } else {
        // Handle digit input
        if (_output == '0') {
          _output = value; // Replace '0' with the pressed digit
        } else {
          _output += value; // Append digit to the current output
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display output (main screen)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Grid layout for buttons
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  String buttonText;
                  if (index < 9) {
                    buttonText = (index + 1).toString(); // 1-9
                  } else if (index == 9) {
                    buttonText = '0'; // 0
                  } else {
                    switch (index) {
                      case 10:
                        buttonText = '+';
                        break;
                      case 11:
                        buttonText = '-';
                        break;
                      case 12:
                        buttonText = '*';
                        break;
                      case 13:
                        buttonText = '/';
                        break;
                      case 14:
                        buttonText = 'C';
                        break;
                      case 15:
                        buttonText = '=';
                        break;
                      default:
                        buttonText = '';
                        break;
                    }
                  }
                  return SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () => _onButtonPressed(buttonText),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
      
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

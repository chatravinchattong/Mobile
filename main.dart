import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";
  double firstNum = 0;
  String operator = "";

  // ปุ่มทั้งหมดเรียงแบบเดียวกับรูป
  final List<String> buttons = [
    "7", "8", "9", "+",
    "4", "5", "6", "-",
    "1", "2", "3", "*",
    "0", "C", "=", "/",
  ];

  void onPressed(String value) {
    setState(() {
      if (value == "C") {
        display = "0";
        firstNum = 0;
        operator = "";
        return;
      }

      if (value == "+" || value == "-" || value == "*" || value == "/") {
        firstNum = double.tryParse(display) ?? 0;
        operator = value;
        display = "0";
        return;
      }

      if (value == "=") {
        double secondNum = double.tryParse(display) ?? 0;
        double result = 0;

        switch (operator) {
          case "+": result = firstNum + secondNum; break;
          case "-": result = firstNum - secondNum; break;
          case "*": result = firstNum * secondNum; break;
          case "/":
            result = secondNum != 0 ? firstNum / secondNum : double.nan;
            break;
        }

        display = (result.isNaN) ? "Error" : result.toString();
        operator = "";
        return;
      }

      // ถ้าเป็นตัวเลข
      if (display == "0") {
        display = value;
      } else {
        display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EFFF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Calculator",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              display,
              style: const TextStyle(
                fontSize: 60,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  String btn = buttons[index];

                  Color bgColor = const Color(0xFFDCCBFF); // สีม่วงอ่อน
                  Color textColor = Colors.black;

                  if (btn == "C") {
                    bgColor = const Color(0xFF8F63FF); // ปุ่มสีม่วงเข้ม
                    textColor = Colors.white;
                  }

                  if (btn == "=") {
                    bgColor = Colors.white;
                  }

                  return ElevatedButton(
                    onPressed: () => onPressed(btn),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      btn,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
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

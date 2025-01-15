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
      title: 'Calculadora Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayText = '';
  String result = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '';
        result = '';
      } else if (value == '=') {
        try {
          // Simples cálculo da expressão
          result = _calculateExpression(displayText);
        } catch (e) {
          result = 'Erro';
        }
      } else {
        displayText += value;
      }
    });
  }

  String _calculateExpression(String expression) {
    // Aqui você pode usar uma biblioteca como o "math_expressions" para avaliar a expressão.
    // Este é apenas um exemplo simples:
    double eval = 0;
    if (expression.contains('+')) {
      var parts = expression.split('+');
      eval = double.parse(parts[0]) + double.parse(parts[1]);
    } else if (expression.contains('-')) {
      var parts = expression.split('-');
      eval = double.parse(parts[0]) - double.parse(parts[1]);
    } else if (expression.contains('*')) {
      var parts = expression.split('*');
      eval = double.parse(parts[0]) * double.parse(parts[1]);
    } else if (expression.contains('/')) {
      var parts = expression.split('/');
      eval = double.parse(parts[0]) / double.parse(parts[1]);
    }
    return eval.toString();
  }

  Widget buildButton(String label, {Color color = Colors.purple}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  result,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Column(
              children: [
                Row(children: [buildButton('7'), buildButton('8'), buildButton('9'), buildButton('/')]),
                Row(children: [buildButton('4'), buildButton('5'), buildButton('6'), buildButton('*')]),
                Row(children: [buildButton('1'), buildButton('2'), buildButton('3'), buildButton('-')]),
                Row(children: [buildButton('C', color: Colors.red), buildButton('0'), buildButton('='), buildButton('+')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

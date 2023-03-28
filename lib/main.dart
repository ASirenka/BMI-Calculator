import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(title: 'Kalkulator BMI'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _heightController = TextEditingController();

  final _weightController = TextEditingController();

  double? _bmi;
  String _message = 'Podaj swój wzrost i wagę';

  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);


    setState(() {
      if (height == null || height <= 0 || weight == null || weight <= 0) {
        _message = "Twój wzrost i waga muszą być liczbami dodatnimi";
        return;
      }
      if (height >= 3) {
        _message = "Twój wzrost musi być wpisany w metrach";
        return;
      }
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "Masz niedowagę";
      } else if (_bmi! < 25) {
        _message = "Twoje ciało jest w porządku :)";
      } else if (_bmi! < 30) {
        _message = "Masz nadwagę";
      } else {
        _message = "Masz otyłość";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(widget.title),
        ),
        body: Center(
          child: SizedBox(
            width: 320,
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          labelText: 'Wzrost (m)', icon: Icon(Icons.height)),
                      controller: _heightController,
                    ),
                    TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          labelText: 'Waga (kg)',
                          icon: Icon(Icons.monitor_weight)),
                      controller: _weightController,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // background
                      ),
                      onPressed: _calculate,
                      child: const Text('Oblicz'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      _bmi == null ? 'Brak wyników' : _bmi!.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _message,
                      style: const TextStyle(fontSize: 15, color: Colors.green),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

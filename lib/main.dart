import 'package:flutter/material.dart';
import 'package:isdbtb_calculator/isdbt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora ISDB-Tb',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculadora ISDB-Tb"),),
        body: isdbtScreen(),)
    );
  }
}


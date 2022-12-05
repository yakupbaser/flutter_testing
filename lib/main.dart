import 'package:flutter/material.dart';
import 'package:flutter_testing/calculator.dart';
import 'package:flutter_testing/operation.dart';
import 'package:flutter_testing/two_digit_operation.dart';

import 'pi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late Calculator calc;

  @override
  void initState() {
    calc = Calculator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            TwoDigitOperation(
              operation: Operation.divide,
              calculator: calc,
              onCalculated: () {},
            ),
            Pi(calculator: calc),
          ],
        ));
  }
}

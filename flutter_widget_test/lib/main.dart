import 'package:flutter/material.dart';
import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/operation.dart';
import 'package:flutter_widget_test/two_digit_operation.dart';

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
        body: TwoDigitOperation(
          operation: Operation.divide,
          calculator: calc,
          onCalculated: () {},
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/operation.dart';

class TwoDigitOperation extends StatefulWidget {
  final Operation operation;
  final Calculator calculator;

  const TwoDigitOperation({
    super.key,
    required this.operation,
    required this.calculator,
  });

  @override
  State<TwoDigitOperation> createState() => _TwoDigitOperationState();
}

class _TwoDigitOperationState extends State<TwoDigitOperation> {
  late TextEditingController controllerTextfieldTop;
  late TextEditingController controllerTextfieldBottom;
  num result = 0;

  @override
  void initState() {
    controllerTextfieldTop = TextEditingController();
    controllerTextfieldBottom = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controllerTextfieldTop,
          key: const Key('textfield_top_plus'),
        ),
        TextField(
          controller: controllerTextfieldBottom,
          key: const Key('textfield_bottom_plus'),
        ),
        ElevatedButton(
            key: const Key('calc_button'),
            onPressed: () {
              final a = num.tryParse(controllerTextfieldTop.text) ?? 0;
              final b = num.tryParse(controllerTextfieldBottom.text) ?? 0;

              _calculate(a, b).then((value) {
                setState(() {
                  result = value;
                });
              });
            },
            child: const Icon(Icons.add)),
        Text(
          'result=$result',
          key: const Key('result_text'),
        )
      ],
    );
  }

  Future<num> _calculate(num a, num b) async {
    num result;
    switch (widget.operation) {
      case Operation.add:
        result = await Future.value(widget.calculator.add(a, b));
        break;
      case Operation.substract:
        result = await Future.value(widget.calculator.substract(a, b));
        break;
      case Operation.divide:
        result = await Future.value(widget.calculator.divide(a, b));
        break;
      case Operation.powerTo:
        result = await widget.calculator.powerTo(a, b);
        break;
      default:
        result = await Future.value(widget.calculator.multiply(a, b));
    }
    return result;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_widget_test/calculator.dart';

class Pi extends StatelessWidget {
  final Calculator calculator;

  const Pi({
    super.key,
    required this.calculator,
  });

  @override
  Widget build(BuildContext context) {
    String? result;
    return StreamBuilder(
      stream: calculator.pi(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          result = snapshot.data.toString();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result != null
                  ? 'The lastest known value of pi is $result'
                  : 'Calculating pi..',
              key: const Key('stream_text'),
            )
          ],
        );
      },
    );
  }
}

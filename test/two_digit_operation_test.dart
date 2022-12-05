import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/calculator.dart';
import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/operation.dart';
import 'package:flutter_testing/pi.dart';
import 'package:flutter_testing/two_digit_operation.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculator extends Mock implements Calculator {}

void main() {
  late MockCalculator calc;
  late Finder finderTextfieldTop;
  late Finder finderTextfieldBottom;
  late Finder finderButton;
  late bool isCalculated;

  setUp(() {
    calc = MockCalculator();
    finderTextfieldTop = find.byKey(const Key('textfield_top_plus'));
    finderTextfieldBottom = find.byKey(const Key('textfield_bottom_plus'));
    finderButton = find.byKey(const Key('calc_button'));
    isCalculated = false;
  });

  group('TwoDigitOperation', () {
    group('Operation.add', () {
      testWidgets('result should be 4 when adding 3 and 1', (tester) async {
        when(() => calc.add(3, 1)).thenReturn(4);

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              operation: Operation.add,
              calculator: calc,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);
        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '3');

        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);
        await tester.enterText(finderTextfieldBottom, '1');

        await tester.ensureVisible(finderButton);
        await tester.tap(finderButton);

        await tester.pumpAndSettle();

        expect(find.text('result=4'), findsOneWidget);
      });
    });

    group('Operation.powerto', () {
      testWidgets('result should be 9 when 3 power to 2', (tester) async {
        when(() => calc.powerTo(3, 2)).thenAnswer((_) => Future.value(9));

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              operation: Operation.powerTo,
              calculator: calc,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);
        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '3');

        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);
        await tester.enterText(finderTextfieldBottom, '2');

        await tester.ensureVisible(finderButton);
        await tester.tap(finderButton);

        await tester.pumpAndSettle();
        expect(find.text('result=9'), findsOneWidget);
      });
    });

    group('Operation.divide', () {
      testWidgets('result should be 5 when divide 10 to 2', (tester) async {
        when(() => calc.divide(10, 2)).thenReturn(5);
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              operation: Operation.divide,
              calculator: calc,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);
        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '10');

        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);
        await tester.enterText(finderTextfieldBottom, '2');

        await tester.ensureVisible(finderButton);
        await tester.tap(finderButton);

        await tester.pumpAndSettle();
        expect(find.text('result=5'), findsOneWidget);
      });
      testWidgets('result should be 0 when divide 10 to 0', (tester) async {
        when(() => calc.divide(10, 0))
            .thenThrow(Exception('i am big errorrr!!!'));
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              operation: Operation.divide,
              calculator: calc,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);
        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '10');

        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);
        await tester.enterText(finderTextfieldBottom, '0');

        await tester.ensureVisible(finderButton);

        await tester.tap(finderButton);

        await tester.pumpAndSettle();

        // verify stubbed calc.divide called for once
        verify(() => calc.divide(10, 0)).called(1);

        // isCalculated should be false because of throw exception from mock
        expect(isCalculated, false);
      });
    });

    group('Pi', () {
      testWidgets('renders the result provided by the calculator',
          (tester) async {
        when(() => calc.pi()).thenAnswer(
          (invocation) => Stream.periodic(
            const Duration(milliseconds: 4),
            ((eventIndex) {
              if (eventIndex == 0) return 3.1;
              if (eventIndex == 1) return 3.14;
              if (eventIndex == 2) return 3.141;
              return null;
            }),
          ),
        );

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(body: Pi(calculator: calc)),
        ));

        late Finder finderStreamText;
        finderStreamText = find.byKey(const Key('stream_text'));
        expect(finderStreamText, findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(
            find.text('The lastest known value of pi is 3.1'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(
            find.text('The lastest known value of pi is 3.14'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(find.text('The lastest known value of pi is 3.141'),
            findsOneWidget);
      });
    });

    testWidgets('matches golden file', (tester) async {
      await tester.pumpWidget(const MyApp());
      await expectLater(
          find.byType(MyApp), matchesGoldenFile('goldens/calculator_app.png'));
    });
  });
}

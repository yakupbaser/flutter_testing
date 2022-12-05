import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;
  late SerializableFinder finderTextfieldTop;
  late SerializableFinder finderTextfieldBottom;
  late SerializableFinder finderButton;

  setUp(() {
    finderTextfieldTop = find.byValueKey('textfield_top_plus');
    finderTextfieldBottom = find.byValueKey('textfield_bottom_plus');
    finderButton = find.byValueKey('calc_button');
  });

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() {
    driver.close();
  });

  test('the values of pi are 3.0, 3.1, 3.14, 3.141 and 3.1415', () async {
    await driver.waitFor(find.text('Calculating pi..'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.0'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.0'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.1'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.14'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.141'));
    await driver.waitFor(find.text('The lastest known value of pi is 3.1415'));
  });

  test('multiplying 5 and 10 shows 50', () async {
    await driver.tap(finderTextfieldTop);
    await driver.enterText('5');
    await driver.tap(finderTextfieldBottom);
    await driver.enterText('10');
    await driver.waitFor(find.text('result=50'));
  });
}

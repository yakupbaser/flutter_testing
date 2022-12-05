import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

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
}

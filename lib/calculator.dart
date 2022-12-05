import 'dart:math';

class Calculator {
  num add(num a, num b) => a + b;

  num substract(num a, num b) => a - b;

  num multiply(num a, num b) => a * b;

  num divide(num a, num b) {
    if (b == 0) {
      throw ArgumentError('you can not divide by zero');
    }
    return a / b;
  }

  Future<num> powerTo(num a, num b) async {
    return Future.delayed(const Duration(seconds: 0), () => pow(a, b));
  }

  Stream<num?> pi() => Stream.fromIterable([3, 3.1, 3.14, 3.141, 3.1415]);
}

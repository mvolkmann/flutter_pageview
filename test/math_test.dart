import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pageview/math.dart';

void main() {
  group('math', () {
    test('addition', () {
      expect(add(0, 0), 0);
      expect(add(0, 1), 1);
      expect(add(1, 1), 2);
    });

    test('multiplication', () {
      expect(multiply(0, 0), 0);
      expect(multiply(0, 1), 0);
      expect(multiply(1, 1), 1);
    });
  });
}

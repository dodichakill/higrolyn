import 'package:agrolyn/utils/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRelativeTime Now', () {
    test('should format relative time - Baru saja', () async {
      String inputDate = "Wed, 15 Jan 2025 06:53:54 GMT";
      String result = await formatRelativeTime(inputDate);
      expect(result, "Baru saja");
    });
  });
}

import 'package:agrolyn/utils/date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRelativeTime Date', () {
    test('should format relative time - DD MM YYYY', () async {
      String inputDate = "Wed, 13 Nov 2024 21:53:54 GMT";
      String result = await formatRelativeTime(inputDate);
      expect(result, "13 November 2024");
    });
  });
}

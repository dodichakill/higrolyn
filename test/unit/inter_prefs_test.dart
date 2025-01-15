import 'package:agrolyn/utils/inter_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });
  group("InterPrefs Test", () {
    test("init() - should return a correct value", () async {
      await InterPrefs.init();
      InterPrefs.setPrefs('testKey', 'testValue');
      String res = InterPrefs.getPrefs('testKey');
      expect(res, 'testValue');
    });
  });
}

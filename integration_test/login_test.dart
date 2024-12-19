import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test with Correct Credentials',
      (WidgetTester tester) async {
    // Persiapkan SharedPreferences untuk pengujian login
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lakukan pengujian aplikasi
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Mengisi form dengan email dan password yang benar
    await tester.enterText(find.byKey(Key('email')), 'dod@gmail.com');
    await tester.enterText(find.byKey(Key('password')), 'dod123');

    // Menekan tombol login
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle(
        Duration(seconds: 5)); // Tunggu hingga proses login selesai

    // Verifikasi apakah aplikasi berhasil login dan menuju ke halaman Menu
    expect(find.byType(Menu), findsOneWidget);
  });
}

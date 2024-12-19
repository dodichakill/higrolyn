import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Register test', (WidgetTester tester) async {
    // Memulai aplikasi
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterScreen(),
      ),
    );

    // Mengisi form
    await tester.enterText(find.byKey(Key('name')), 'Faisal Arrahman');
    await tester.enterText(find.byKey(Key('email')), 'faisal@tegal.dev');
    await tester.enterText(find.byKey(Key('phone')), '85183360981');
    await tester.enterText(find.byKey(Key('address')), 'Kaladawa');
    await tester.enterText(find.byKey(Key('password')), 'faisal123');
    await tester.enterText(find.byKey(Key('retype_password')), 'faisal123');

    // Menekan tombol register
    final registerButton = find.byKey(Key('register_button'));
    expect(registerButton, findsOneWidget); // Pastikan tombol register ada
    await tester.tap(registerButton, warnIfMissed: false);
    await tester.pumpAndSettle(
        Duration(seconds: 5)); // Tunggu hingga proses login selesai

    // Verifikasi apakah aplikasi berhasil regis dan menuju ke halaman login
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

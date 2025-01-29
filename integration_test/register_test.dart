import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Register Screen Integration Tests', () {
    testWidgets('Successful Registration Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

      // Verifikasi halaman RegisterScreen
      expect(find.text('Daftar Akun'), findsOneWidget);

      // Isi semua field
      await tester.enterText(find.byKey(const Key('Nama')), 'Faisal Arrahman');
      await tester.enterText(
          find.byKey(const Key('Email')), 'faissaal@tegall.dev');
      await tester.enterText(
          find.byKey(const Key('Nomor Hp')), '+6285183360982');
      await tester.enterText(find.byKey(const Key('Alamat')), 'Kaladawa');
      await tester.enterText(find.byKey(const Key('Kata Sandi')), 'faisal123');

      // Pastikan tombol register terlihat dan aktif
      final registerButton = find.byKey(const Key('registerButton'));
      await tester.ensureVisible(registerButton);
      expect(registerButton, findsOneWidget);
      expect(tester.widget<ElevatedButton>(registerButton).enabled, isTrue);

      // Tekan tombol register
      await tester.tap(registerButton);

      // Tunggu hingga animasi dan perubahan UI selesai
      await tester.pumpAndSettle(const Duration(
          seconds: 5)); // Pastikan ini dilakukan setelah aksi tap

      // Verifikasi navigasi ke LoginScreen
      expect(find.byType(LoginScreen), findsOneWidget,
          reason:
              'Navigasi ke halaman login harus berhasil setelah registrasi.');
    });
  });
}

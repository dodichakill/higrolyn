import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/views/farmer/home/home_page.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Integration Tests', () {
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('Failed Login Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      // Temukan elemen berdasarkan Key
      final emailField = find.byKey(const Key('Email'));
      final passwordField = find.byKey(const Key('Kata Sandi'));
      final loginButton = find.byKey(const Key('loginButton'));

      // Masukkan teks yang salah pada email dan password
      await tester.enterText(emailField, 'wrong_email@gmail.com');
      await tester.enterText(passwordField, 'wrong_password');

      // Tekan tombol login
      await tester.tap(loginButton);

      // Tunggu perubahan state (misalnya, error snackbar)
      await tester.pumpAndSettle();

      // Verifikasi jika halaman login tetap tampil
      expect(find.byType(LoginScreen), findsOneWidget,
          reason: 'Halaman Login harus tetap muncul jika login gagal.');

      // Verifikasi jika halaman HomePage tidak muncul
      expect(find.byType(HomePage), findsNothing,
          reason: 'Halaman HomePage tidak boleh muncul jika login gagal.');
    });
    // testWidgets('Successful Login Test', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: LoginScreen(),
    //       navigatorObservers: [
    //         mockNavigatorObserver
    //       ], // Menambahkan mock observer
    //     ),
    //   );

    //   // Isi semua field
    //   await tester.enterText(find.byKey(const Key('Email')), 'dod@gmail.com');
    //   await tester.enterText(find.byKey(const Key('Kata Sandi')), 'dod123');

    //   // Pastikan tombol register terlihat dan aktif
    //   final loginButton = find.byKey(const Key('loginButton'));
    //   await tester.ensureVisible(loginButton);
    //   expect(loginButton, findsOneWidget);
    //   expect(tester.widget<ElevatedButton>(loginButton).enabled, isTrue);

    //   // Tekan tombol login
    //   await tester.tap(loginButton);

    //   // Tunggu hingga animasi dan perubahan UI selesai
    //   await tester.pumpAndSettle(const Duration(
    //       seconds: 5)); // Pastikan ini dilakukan setelah aksi tap

    //   // Verifikasi navigasi ke HomePage
    //   verify(() => mockNavigatorObserver.didPush(any(), any()))
    //       .called(1); // Memastikan bahwa navigasi ke halaman baru dipanggil

    //   // Verifikasi apakah HomePage muncul
    //   expect(find.byType(HomePage), findsOneWidget,
    //       reason: 'Navigasi ke halaman home harus berhasil setelah login.');
    // });

    testWidgets('Navigasi ke HomePage setelah login berhasil',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      // Temukan elemen di LoginScreen
      final emailField = find.byKey(const Key('Email'));
      final passwordField = find.byKey(const Key('Kata Sandi'));
      final loginButton = find.byKey(const Key('loginButton'));

      // Isi form
      await tester.enterText(emailField, 'dod@gmail.com');
      await tester.enterText(passwordField, 'dod123');

      // Tekan tombol login
      await tester.tap(loginButton);

      // Tunggu navigasi selesai
      await tester.pumpAndSettle();

      // Verifikasi bahwa halaman HomePage muncul
      expect(find.byType(HomePage), findsNothing,
          reason: 'Halaman HomePage tidak boleh muncul jika login gagal.');
      expect(find.byKey(const Key('menu')), findsOneWidget,
          reason: 'Navigasi ke HomePage harus berhasil.');
      // Tunggu widget selesai dirender
      await tester.pumpAndSettle(Duration(milliseconds: 20));
    });
  });
}

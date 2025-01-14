import 'package:agrolyn/views/auth/forgot_password_screen.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test - Forgot Password Screen',
      (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(MaterialApp(
      home: ForgotPasswordScreen(),
    ));

    // Tunggu widget selesai dirender
    await tester.pumpAndSettle();

    // Verifikasi elemen utama muncul di layar
    expect(find.text("Lupa Kata Sandi"), findsOneWidget); // AppBar title
    expect(find.byType(TextFormField), findsOneWidget); // Form email
    expect(find.text("Reset Kata Sandi"), findsOneWidget); // Button
    expect(find.byType(Image), findsOneWidget); // Gambar lupa sandi

    // Input email valid
    final emailField = find.byType(TextFormField);
    await tester.enterText(emailField, "faisal@tegal.dev");
    await tester.pumpAndSettle();

    // Tekan tombol reset
    final resetButton = find.text("Reset Kata Sandi");
    await tester.tap(resetButton);
    await tester.pumpAndSettle();

    // Verifikasi Snackbar tampil setelah reset
    expect(
      find.text(
          "Permintaan Reset kata sandi telah dikirimkan ke alamat email anda"),
      findsOneWidget,
    );

    // Verifikasi navigasi ke LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

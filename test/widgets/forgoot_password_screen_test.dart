import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agrolyn/views/auth/forgot_password_screen.dart';
import 'package:agrolyn/providers/login_notifier.dart';

class MockLoginNotifier extends Mock implements LoginNotifier {}

void main() {
  group('ForgotPasswordScreen Widget Test', () {
    testWidgets('should display all UI elements', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(home: ForgotPasswordScreen()),
      );
      await tester.pumpAndSettle();

      // Assert: Pastikan elemen UI utama ada
      expect(find.text('Lupa Kata Sandi'), findsOneWidget,
          reason: 'Judul "Lupa Kata Sandi" harus ada');
      expect(
          find.text(
              'masukkan alamat email yang terkait dengan akun Anda dan kami akan mengirimkan email untuk mengatur ulang kata sandi Anda'),
          findsOneWidget,
          reason: 'Instruksi reset kata sandi harus ada');
      expect(find.byType(TextFormField), findsOneWidget,
          reason: 'Harus ada satu input field untuk email');
      expect(find.text('Reset Kata Sandi'), findsOneWidget,
          reason: 'Tombol Reset Kata Sandi harus ada');
      expect(find.byType(CircularProgressIndicator), findsNothing,
          reason: 'Loading spinner tidak boleh muncul saat isLoading = false');
    });
  });
}

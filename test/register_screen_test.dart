import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:agrolyn/providers/register_notifier.dart';

class MockRegisterNotifier extends Mock implements RegisterNotifier {}

void main() {
  late MockRegisterNotifier mockRegisterNotifier;

  setUp(() {
    mockRegisterNotifier = MockRegisterNotifier();

    // Mock properti yang digunakan
    when(() => mockRegisterNotifier.isLoading).thenReturn(false);
    when(() => mockRegisterNotifier.nameController)
        .thenReturn(TextEditingController());
    when(() => mockRegisterNotifier.emailController)
        .thenReturn(TextEditingController());
    when(() => mockRegisterNotifier.phoneController)
        .thenReturn(TextEditingController());
    when(() => mockRegisterNotifier.addressController)
        .thenReturn(TextEditingController());
    when(() => mockRegisterNotifier.passwordController)
        .thenReturn(TextEditingController());
  });

  group('RegisterScreen Widget Test', () {
    testWidgets('should display all UI elements', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<RegisterNotifier>.value(
            value: mockRegisterNotifier,
            child: const RegisterScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert: Pastikan elemen UI utama ada
      expect(find.text('Daftar Akun'), findsOneWidget,
          reason: 'Judul "Daftar Akun" harus ada');
      expect(find.text('Daftar Akun Untuk Mengakses Aplikasi'), findsOneWidget,
          reason: 'Subjudul harus ada');
      expect(find.byType(TextFormField), findsNWidgets(5),
          reason: 'Harus ada 5 input field');
      expect(find.text('Nama'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Nomor Hp'), findsOneWidget);
      expect(find.text('Alamat'), findsOneWidget);
      expect(find.text('Kata Sandi'), findsOneWidget);
      expect(find.byKey(const Key('registerButton')), findsOneWidget,
          reason: 'Tombol "Masuk" harus ada');
      expect(find.text('Sudah Punya Akun ?'), findsOneWidget,
          reason: 'Teks "Sudah Punya Akun ?" harus ada');
      expect(find.text('Masuk'), findsOneWidget,
          reason: 'Link "Masuk" harus ada');

      // Pastikan tidak ada loading spinner
      expect(find.byType(CircularProgressIndicator), findsNothing,
          reason: 'Loading spinner tidak boleh muncul saat isLoading = false');
    });
  });
}

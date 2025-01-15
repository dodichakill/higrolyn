import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/providers/login_notifier.dart';

class MockLoginNotifier extends Mock implements LoginNotifier {}

void main() {
  late MockLoginNotifier mockLoginNotifier;

  setUp(() {
    mockLoginNotifier = MockLoginNotifier();

    // Mock properti yang digunakan
    when(() => mockLoginNotifier.isLoading).thenReturn(false);
    when(() => mockLoginNotifier.emailController)
        .thenReturn(TextEditingController());
    when(() => mockLoginNotifier.passwordController)
        .thenReturn(TextEditingController());
    when(() => mockLoginNotifier.keyfrom).thenReturn(GlobalKey<FormState>());
  });

  group('LoginScreen Widget Test', () {
    testWidgets('should display all UI elements', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<LoginNotifier>.value(
            value: mockLoginNotifier,
            child: const LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert: Periksa elemen UI utama
      expect(find.text('Masuk'), findsWidgets); // Periksa semua "Masuk"
      expect(find.text('Agrolyn'), findsOneWidget);
      expect(find.text('Silahkan Masuk untuk melanjutkan'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2),
          reason: 'Harus ada 2 input field');
      expect(find.byKey(const Key('loginButton')), findsOneWidget,
          reason: 'Tombol "Masuk" harus ada');

      // Tambahan: Pastikan tidak ada loading
      expect(find.byType(CircularProgressIndicator), findsNothing,
          reason: 'Tidak ada indikator loading saat isLoading = false');

      // Tambahan: Periksa link "Lupa Kata Sandi" dan "Daftar Akun"
      expect(find.text('Lupa Kata Sandi'), findsOneWidget,
          reason: 'Link Lupa Kata Sandi harus ada');
      expect(find.text('Daftar Akun'), findsOneWidget,
          reason: 'Link Daftar Akun harus ada');
    });
  });
}

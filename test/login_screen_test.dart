import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/login_notifier.dart';
import 'package:dio/dio.dart';

// Mock class untuk Dio
class MockDio extends Mock implements Dio {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();

    // Simulasikan SharedPreferences mengembalikan token
    when(() => mockSharedPreferences.getString('access_token'))
        .thenReturn('dummy_token');
    when(() => mockSharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => true);

    // Gunakan Dio yang sudah dimock langsung di AuthService
    AuthService().setDio = mockDio; // Set Dio yang sudah dimock
    AuthService().setSharedPreferences = mockSharedPreferences;
  });

  group("LoginScreen Widget Test", () {
    testWidgets("semua widget ada", (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginNotifier(
                context: tester.element(find.byType(LoginScreen))),
            child: LoginScreen(),
          ),
        ),
      );

      // Verifikasi apakah widget email, password, dan login_button ada
      expect(find.byKey(Key('email')), findsOneWidget);
      expect(find.byKey(Key('password')), findsOneWidget);
      expect(find.byKey(Key('login_button')), findsOneWidget);
    });

    testWidgets("tombol Masuk berfungsi dengan token di SharedPreferences",
        (WidgetTester tester) async {
      // Simulasi login sukses dengan mock Dio
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
                data: {
                  'access_token': 'dummy_token',
                  'refresh_token': 'dummy_refresh_token',
                },
              ));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginNotifier(
                context: tester.element(find.byType(LoginScreen))),
            child: LoginScreen(),
          ),
        ),
      );

      // Mengisi field email dan password
      await tester.enterText(find.byKey(Key('email')), 'dod@gmail.com');
      await tester.enterText(find.byKey(Key('password')), 'dod123');

      // Menekan tombol login
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle(); // Tunggu proses login selesai

      // Verifikasi apakah login berhasil dan menuju ke halaman Menu
      expect(find.byType(Menu), findsOneWidget);
    });

    testWidgets("tombol Masuk menampilkan pesan error jika login gagal",
        (WidgetTester tester) async {
      // Simulasi login gagal dengan mock Dio
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 400, // Simulasi status 400
                data: {'message': 'Invalid credentials'},
              ));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginNotifier(
                context: tester.element(find.byType(LoginScreen))),
            child: LoginScreen(),
          ),
        ),
      );

      // Mengisi field email dan password
      await tester.enterText(find.byKey(Key('email')), 'dod@gmail.com');
      await tester.enterText(find.byKey(Key('password')), 'wrongpassword');

      // Menekan tombol login
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle(); // Tunggu proses login selesai

      // Verifikasi apakah ada pesan error
      expect(find.text('Login Gagal'), findsOneWidget);
    });
  });
}

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

  setUp(() async {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();

    // Simulasikan SharedPreferences mengembalikan token yang sudah ada
    when(() => mockSharedPreferences.getString('access_token')).thenReturn(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNDUxMjg2OCwianRpIjoiZDg4ODljYjItY2JmNi00YWE3LTk3ODUtMTMzOWMzYzA5MjA3IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJpZCI6NDIsImVtYWlsIjoiZG9kQGdtYWlsLmNvbSIsIm5hbWUiOiJkb2RpIiwicm9sZXNfaWQiOjJ9LCJuYmYiOjE3MzQ1MTI4NjgsImNzcmYiOiI4ZTA0MzgwZi01NWFhLTQ3ZDYtYjA4Yi1lNWEwMzI2YWZmYjciLCJleHAiOjE3MzQ1MTY0Njh9.ljLdE2o6U1ftgQv2pygtYEhi4XOmHXMO54t8U-Fh0LI');
    when(() => mockSharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => true);

    // Gunakan Dio yang sudah dimock langsung di AuthService
    AuthService().setDio = mockDio;
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

    testWidgets(
        "tombol Masuk berfungsi dengan token yang sudah ada di SharedPreferences",
        (WidgetTester tester) async {
      // Simulasi login sukses dengan mock Dio
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
                data: {
                  'access_token':
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNDUxMjg2OCwianRpIjoiZDg4ODljYjItY2JmNi00YWE3LTk3ODUtMTMzOWMzYzA5MjA3IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJpZCI6NDIsImVtYWlsIjoiZG9kQGdtYWlsLmNvbSIsIm5hbWUiOiJkb2RpIiwicm9sZXNfaWQiOjJ9LCJuYmYiOjE3MzQ1MTI4NjgsImNzcmYiOiI4ZTA0MzgwZi01NWFhLTQ3ZDYtYjA4Yi1lNWEwMzI2YWZmYjciLCJleHAiOjE3MzQ1MTY0Njh9.ljLdE2o6U1ftgQv2pygtYEhi4XOmHXMO54t8U-Fh0LI',
                  'refresh_token':
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNDUxMjg2OCwianRpIjoiMDk2OTBlNDUtYWY1My00NWRlLWE5ODktNDdjZDNiN2YwMWY1IiwidHlwZSI6InJlZnJlc2giLCJzdWIiOnsiaWQiOjQyLCJlbWFpbCI6ImRvZEBnbWFpbC5jb20iLCJuYW1lIjoiZG9kaSIsInJvbGVzX2lkIjoyfSwibmJmIjoxNzM0NTEyODY4LCJjc3JmIjoiZDk3MGM0YmItNGFjZS00YWRmLWFkOWMtZDNkMzc2OWNmZTI3IiwiZXhwIjoxNzM1MTE3NjY4fQ.gjvbdGlHPxDMowd1UPaGTkNJzTQadWcmdXjrW9iTHko',
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
  });
}

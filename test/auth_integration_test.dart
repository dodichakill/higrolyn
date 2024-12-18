// test/services/auth_service_test.dart
import 'package:agrolyn/api/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Membuat Mock untuk Dio
class MockDio extends Mock implements Dio {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late AuthService authService;

  setUp(() {
    authService = AuthService();
  });

  group('AuthService login', () {
    testWidgets('returns true when login is successful',
        (WidgetTester tester) async {
      // Arrange
      const email = 'dod@gmail.com';
      const password = 'dod123';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              // Act
              final authService = AuthService();
              final result = authService.login(context, email, password);

              // Assert
              expect(result, completion(isTrue));
              return Container();
            },
          ),
        ),
      ));
    });
  });
}

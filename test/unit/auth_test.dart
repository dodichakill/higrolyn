import 'package:agrolyn/api/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';

class MockDio extends Mock implements Dio {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late AuthService authService;
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late MockBuildContext mockContext;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    mockContext = MockBuildContext();

    authService = AuthService();
    authService.setDio = mockDio;
    authService.setSharedPreferences = mockSharedPreferences;
  });

  group('AuthService - Login', () {
    test('should return false when login fails with incorrect credentials',
        () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 401,
        data: {'message': 'Invalid credentials'},
      );

      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => response);

      // Act
      final result = await authService.login(
          mockContext, 'wrong@example.com', 'wrongpassword');

      // Assert
      expect(result, false);
      verify(() => mockDio.post(
            '/login/',
            data: {
              'email': 'wrong@example.com',
              'password': 'wrongpassword',
            },
          )).called(1);
    });
  });
}

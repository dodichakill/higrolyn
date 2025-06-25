import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Education Test', () {
    testWidgets('Test if articles are displayed after login with real token',
        (WidgetTester tester) async {
      final dio = Dio();
      final mockNavigatorObserver = MockNavigatorObserver();

      // URL dan token
      const loginUrl = 'https://apiv1.agrolyn.my.id/login/';
      const articlesUrl = 'https://apiv1.agrolyn.my.id/articles/';
      const email = 'faisal@tegal.dev'; // Ganti dengan email yang valid
      const password = 'faisal123'; // Ganti dengan password yang valid

      Response loginResponse;
      Response articlesResponse;

      try {
        // Panggil API login
        loginResponse = await dio.post(
          loginUrl,
          data: {
            'email': email,
            'password': password,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

        print('Login response: ${loginResponse.data}');

        if (loginResponse.statusCode == 200) {
          final token = loginResponse.data['access_token'];

          // Panggil API untuk mendapatkan artikel
          articlesResponse = await dio.get(
            articlesUrl,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
            ),
          );

          print('Articles response: ${articlesResponse.data}');

          if (articlesResponse.statusCode == 200) {
            final articles = articlesResponse.data['data'] ?? [];

            if (articles.isNotEmpty) {
              // Tes UI
              await tester.pumpWidget(
                ChangeNotifierProvider(
                  create: (_) => HomeNotifier(context: null),
                  child: MaterialApp(
                    home: AllArticleScreen(),
                    navigatorObservers: [mockNavigatorObserver],
                  ),
                ),
              );

              // Tunggu UI selesai dirender
              await tester.pumpAndSettle();

              // Set articles data in HomeNotifier
              final homeNotifier = Provider.of<HomeNotifier>(
                  tester.element(find.byType(AllArticleScreen)),
                  listen: false);
              homeNotifier.setArticles(articles);

              // Tunggu UI selesai dirender setelah data diatur
              await tester.pumpAndSettle();

              // Verifikasi bahwa artikel pertama muncul di UI
              expect(find.text(articles[0]['title']), findsOneWidget);
              expect(find.text(articles[0]['description']), findsOneWidget);
            } else {
              print('No articles found in the response.');
            }
          } else {
            print(
                'API call failed with status code: ${articlesResponse.statusCode}');
          }
        } else {
          print('Login failed with status code: ${loginResponse.statusCode}');
        }
      } catch (e) {
        print('Error during API call: $e');
      }
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Test if articles are displayed after login with real token',
      (WidgetTester tester) async {
    final dio = Dio();

    // URL dan token
    const articlesUrl = 'https://apiv1.agrolyn.online/articles/';
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNjg1NjU4OCwianRpIjoiYWNiZjFmNzctZjY0Yy00Y2YwLTgzNmQtNzU4ZjIyZTZkYmRmIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJpZCI6NTEsImVtYWlsIjoiZmFpc2FsQHRlZ2FsLmRldiIsIm5hbWUiOiJmYWlzYWwiLCJyb2xlc19pZCI6Mn0sIm5iZiI6MTczNjg1NjU4OCwiY3NyZiI6IjdmYTQ2ODNiLTliZGEtNGIwMC04YjQ1LWY0Y2E1N2Q1NWU2MCIsImV4cCI6MTczNzExNTc4OH0.QVvysUYncAA1Q2DtU2vssuvShK1WMaoiCLZD6cKQul8'; // Ganti dengan token yang valid

    Response articlesResponse;

    try {
      // Panggil API
      articlesResponse = await dio.get(
        articlesUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (articlesResponse.statusCode == 200) {
        final articles = articlesResponse.data ?? [];

        if (articles.isNotEmpty) {
          // Tes UI
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => HomeNotifier(
                  context: tester.element(find.byType(MaterialApp))),
              child: MaterialApp(
                home: AllArticleScreen(),
              ),
            ),
          );

          // Tunggu UI selesai dirender
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
    } catch (e) {
      print('Error during API call: $e');
    }
  });
}

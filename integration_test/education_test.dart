import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Test if articles are displayed after login with real token',
      (WidgetTester tester) async {
    final dio = Dio(); // Menggunakan Dio asli untuk request nyata

    // URL artikel
    const articlesUrl =
        'https://apiv1.agrolyn.on1line/articles/'; // Ganti dengan URL artikel yang benar

    // Isi token manual di sini
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNDUzNjExMywianRpIjoiOWNkMjMyYzgtMjhiZS00YmRmLWFjMDItYWQwOWYwNjk2MGI1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJpZCI6NDIsImVtYWlsIjoiZG9kQGdtYWlsLmNvbSIsIm5hbWUiOiJLaW5nIERvZGkgSGVybGFuZ2dhIiwicm9sZXNfaWQiOjJ9LCJuYmYiOjE3MzQ1MzYxMTMsImNzcmYiOiJiZDU4ODZkOS1kODFiLTQ0NDEtOTExYi1iOTZiOTVkMDNhOGMiLCJleHAiOjE3MzQ1Mzk3MTN9.i5DcwW4pJopFM3F4tRrlprnEK5dawey18FwoOEeSlk8'; // Ganti dengan token yang valid

    // Mengambil artikel menggunakan token manual
    Response articlesResponse;
    try {
      // Mengambil artikel dengan token yang sudah diisi manual
      articlesResponse = await dio.get(
        articlesUrl,
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Menambahkan token manual pada header
            'Content-Type': 'application/json',
          },
        ),
      );

      // Debugging: print response untuk memastikan data yang diterima
      print('Response status code: ${articlesResponse.statusCode}');
      print('Response data: ${articlesResponse.data}');

      if (articlesResponse.statusCode == 200) {
        // Pastikan artikel yang diambil valid
        final articles = articlesResponse.data ?? [];

        if (articles.isNotEmpty) {
          print('Successfully fetched articles!');

          // Pastikan tipe data artikel sesuai
          for (var article in articles) {
            print('Article Title: ${article['title']}');
            print('Article Description: ${article['description']}');
          }

          // Bangun widget untuk diuji
          await tester.pumpWidget(
            ChangeNotifierProvider<HomeNotifier>.value(
              value: HomeNotifier(
                  context:
                      null), // Menyediakan HomeNotifier dengan context null untuk pengujian
              child: MaterialApp(
                home: AllArticleScreen(),
              ),
            ),
          );

          // Tunggu widget selesai dirender
          await tester.pumpAndSettle();

          // Verifikasi bahwa artikel yang diterima tampil di UI
          expect(find.text(articles[0]['title']),
              findsOneWidget); // Menggunakan judul artikel pertama untuk verifikasi
          expect(find.text(articles[0]['description']),
              findsOneWidget); // Menggunakan deskripsi artikel pertama
        } else {
          print('No articles found.');
        }
      } else {
        print(
            'Failed to fetch articles, status code: ${articlesResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching articles: $e');
      return;
    }
  });
}

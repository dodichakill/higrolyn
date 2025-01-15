import 'package:agrolyn/views/chatbot/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn/providers/chatbot_notifier.dart';

class MockChatbotNotifier extends Mock implements ChatbotNotifier {}

void main() {
  late MockChatbotNotifier mockChatbotNotifier;

  setUp(() {
    mockChatbotNotifier = MockChatbotNotifier();

    // Mock properti yang digunakan
    when(() => mockChatbotNotifier.isLoading).thenReturn(false);
    when(() => mockChatbotNotifier.list).thenReturn([]);
    when(() => mockChatbotNotifier.listGroq).thenReturn([]);
    when(() => mockChatbotNotifier.chat).thenReturn(TextEditingController());
    when(() => mockChatbotNotifier.chatGroq)
        .thenReturn(TextEditingController());
  });

  group('Chatbot Screen Widget Test', () {
    testWidgets('should display all UI elements', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<ChatbotNotifier>.value(
            value: mockChatbotNotifier,
            child: const Chatbot(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert: Periksa elemen UI utama pada tab pertama
      expect(find.text('Agrobot'), findsOneWidget,
          reason: 'Judul "Agrobot" harus ada');
      expect(find.text('Powered by'), findsNWidgets(2),
          reason: 'Tab dengan label "Powered by" harus ada dua');
      expect(find.byType(TabBar), findsOneWidget, reason: 'TabBar harus ada');
      expect(find.byType(ListView), findsOneWidget,
          reason: 'ListView untuk pesan di tab pertama harus ada');
      expect(find.byType(TextField), findsOneWidget,
          reason: 'TextField untuk input pesan di tab pertama harus ada');

      // Act: Berpindah ke tab kedua
      await tester.tap(find.text('Powered by').last); // Tab kedua
      await tester.pumpAndSettle();

      // Assert: Periksa elemen UI utama pada tab kedua
      expect(find.byType(ListView), findsOneWidget,
          reason: 'ListView untuk pesan di tab kedua harus ada');
      expect(find.byType(TextField), findsOneWidget,
          reason: 'TextField untuk input pesan di tab kedua harus ada');
    });
  });
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:agrolyn/models/chat_new_model.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatbotNotifier extends ChangeNotifier {
  final BuildContext context;
  TextEditingController chat = TextEditingController();
  final Gemini gemini = Gemini.instance;
  List<ChatNewModel> list = [];

  ChatbotNotifier({required this.context});

  void submit(String value) {
    var newChat = ChatNewModel(
      id: list.isEmpty ? 1 : list.last.id + 1,
      posisi: "kanan",
      chat: value,
      createdDate: DateTime.now().toString(),
      type: "text",
      status: "receive",
    );

    list.insert(0, newChat);
    chat.clear();
    notifyListeners();

    gemini.streamGenerateContent(newChat.chat).listen((e) {
      var response = ChatNewModel(
        id: list.first.id + 1,
        posisi: "kiri",
        chat:
            e.content!.parts?.fold("", (prev, part) => "$prev ${part.text}") ??
                "",
        createdDate: DateTime.now().toString(),
        type: "text",
        status: "receive",
      );

      list.insert(0, response);
      notifyListeners();
    });
  }

  void getData() async {
    Dio dio = Dio();
    final response = await dio.get("https://tegaldev.metimes.id/chat-sample");
    final data = jsonDecode(response.data);

    list = [
      for (Map<String, dynamic> i in data['data']) ChatNewModel.fromJson(i)
    ];
    notifyListeners();
  }
}

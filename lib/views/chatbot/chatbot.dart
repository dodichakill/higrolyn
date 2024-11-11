import 'package:flutter/material.dart';
import 'package:agrolyn/providers/chatbot_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:provider/provider.dart';

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatbotNotifier(context: context),
      child: Consumer<ChatbotNotifier>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    ImageAssets.backgroundChatbot,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 16,
                  right: 16,
                  bottom: 80,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: value.list.length,
                    itemBuilder: (context, index) {
                      var e = value.list[index];
                      return Column(
                        crossAxisAlignment: e.posisi == "kiri"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: e.posisi == "kiri"
                                  ? Colors.white
                                  : MyColors.secondaryColorLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              e.chat,
                              style: TextStyle(
                                  color: e.posisi == "kiri"
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.transparent,
                    height: 60,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        Text(
                          "Agrolynbot",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Image.asset(
                          ImageAssets.logoChatbot,
                          width: 48,
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 86,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: value.chat,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () => value.submit(value.chat.text),
                          child: Icon(
                            Icons.send,
                            color: MyColors.primaryColorDark,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

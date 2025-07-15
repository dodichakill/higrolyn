import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/providers/chatbot_notifier.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:provider/provider.dart';

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatbotNotifier(context: context),
      child: Consumer<ChatbotNotifier>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Agrobot',
              style: TextStyle(
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: MyColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
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
                  itemCount: value.listGroq.length,
                  itemBuilder: (context, index) {
                    var e = value.listGroq[index];
                    return Column(
                      crossAxisAlignment: e['res_answer'] == "kiri"
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: e['res_answer'] == "kiri"
                                ? Colors.white
                                : MyColors.primaryColorDark,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomRight: e['res_answer'] == "kiri"
                                  ? const Radius.circular(16)
                                  : Radius.zero,
                              bottomLeft: e['res_answer'] == "kiri"
                                  ? Radius.zero
                                  : const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            e['message'], // Tampilkan pesan di sini
                            style: TextStyle(
                              color: e['res_answer'] == "kiri"
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 86,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: value.chatGroq,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Masukkan pesan...', // Tambahkan placeholder
                      suffixIcon: InkWell(
                        onTap: () {
                          value.submitGroq(value.chatGroq.text);
                        },
                        child: value.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  color: MyColors.primaryColorDark,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 24,
                                  Icons.send,
                                  color: MyColors.primaryColorDark,
                                ),
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
        );
      }),
    );
  }
}

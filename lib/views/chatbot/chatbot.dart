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
      child: Consumer<ChatbotNotifier>(
        builder: (context, value, child) => DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: MyColors.primaryColorDark), // Kustomisasi icon
                onPressed: () {
                  Navigator.pop(context); // Aksi ketika tombol back ditekan
                },
              ),
              title: const Text("Agrobot",
                  style: TextStyle(
                      color: MyColors.primaryColorDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Powered by'),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              ImageAssets.meta,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Powered by'),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              ImageAssets.groq,
                              height: 65,
                              width: 65,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                indicatorColor: MyColors.primaryColorDark,
                labelColor: MyColors.primaryColorDark,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            body: TabBarView(
              children: [
                SafeArea(
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
                              crossAxisAlignment: e['res_answer'] == "kiri"
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                      color: e['res_answer'] == "kiri"
                                          ? Colors.white
                                          : MyColors.primaryColorDark,
                                      borderRadius: e['res_answer'] == "kiri"
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomRight: Radius.circular(16))
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16))),
                                  child: Text(
                                    e['message'], // Tampilkan pesan di sini
                                    style: TextStyle(
                                        color: e['res_answer'] == "kiri"
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
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 86,
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: value.chat,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  value.submit(value.chat.text);
                                },
                                child: value.isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 1.0,
                                          color: MyColors.primaryColorDark,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(
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
                ),
                SafeArea(
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                      color: e['res_answer'] == "kiri"
                                          ? Colors.white
                                          : MyColors.primaryColorDark,
                                      borderRadius: e['res_answer'] == "kiri"
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomRight: Radius.circular(16))
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16))),
                                  child: Text(
                                    e['message'], // Tampilkan pesan di sini
                                    style: TextStyle(
                                        color: e['res_answer'] == "kiri"
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
                              suffixIcon: InkWell(
                                onTap: () {
                                  value.submitGroq(value.chatGroq.text);
                                },
                                child: value.isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 1.0,
                                          color: MyColors.primaryColorDark,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

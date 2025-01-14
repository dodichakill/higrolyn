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
              title: const Text(
                "Agrobot",
                style: TextStyle(
                  color: MyColors.primaryColorDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: TabBar(
                tabs: [
                  _buildTab('Powered by', ImageAssets.meta),
                  _buildTab('Powered by', ImageAssets.groq),
                ],
                indicatorColor: MyColors.primaryColorDark,
                labelColor: MyColors.primaryColorDark,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            body: TabBarView(
              children: [
                _buildChatView(context, value.list, value.chat, value.submit,
                    value.isLoading),
                _buildChatView(context, value.listGroq, value.chatGroq,
                    value.submitGroq, value.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun Tab
  Widget _buildTab(String label, String imagePath) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(label),
              ],
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                imagePath,
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun Chat View
  Widget _buildChatView(
      BuildContext context,
      List<Map<String, dynamic>> messages,
      TextEditingController chatController,
      Function(String) onSubmit,
      bool isLoading) {
    return SafeArea(
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
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var e = messages[index];
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
                controller: chatController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Masukkan pesan...', // Tambahkan placeholder
                  suffixIcon: InkWell(
                    onTap: () {
                      onSubmit(chatController.text);
                    },
                    child: isLoading
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
  }
}

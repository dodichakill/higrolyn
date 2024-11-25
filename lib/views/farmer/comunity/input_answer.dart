import 'package:flutter/material.dart';

class InputAnswer extends StatelessWidget {
  InputAnswer({super.key});

  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 3,
              offset: const Offset(0, -2),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black54),
                  cursorColor: Colors.green,
                  controller: answerController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    focusColor: Colors.green,
                    hintText: "Tulis jawabanmu disini...",
                    hintStyle: TextStyle(color: Colors.black54),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(color: Colors.green)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(
                          color: Colors.green,
                        )),
                  ),
                ),
              ),
            ),
            IconButton(
                padding: const EdgeInsets.all(12),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  // value.answerQuestion(
                  //     questionId, answerController.text);
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}

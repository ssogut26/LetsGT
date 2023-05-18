import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:letsgt/core/usecases/paddings.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [];
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the messages list.
    messages.add(
      Message(
        text: 'Hello, world!',
        isCurrentUser: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: AppPaddings.pagePadding,
        child: ListView(
          children: [
            // Create a ListView widget to display the messages.
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  // Create a ChatBubble widget for each message.
                  return const Row(
                    children: [
                      CircleAvatar(),
                      Text(''),
                    ],
                  );
                },
              ),
            ),
            // Create a TextField widget for the user to enter their message.
            TextField(
              controller: textController,
              onSubmitted: (text) {
                // Add the text to the messages list.
                messages.add(
                  Message(
                    text: text,
                    isCurrentUser: true,
                  ),
                );
                // Clear the text field.
                textController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  Message({
    this.text,
    this.isCurrentUser,
  });
  final String? text;
  final bool? isCurrentUser;
}

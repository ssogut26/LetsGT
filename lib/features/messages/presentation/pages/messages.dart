import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:letsgt/core/usecases/paddings.dart';

@RoutePage()
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
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
        title: const Text('Messages'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
      body: const Padding(
        padding: AppPaddings.pagePadding,
        child: Column(
          children: [
            // Create a Row widget for the user's profile picture, name, and status.
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 8),
                Text('ASD'),
                SizedBox(width: 8),
                Text('ASD'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  User({
    this.name,
    this.profilePictureUrl,
    this.status,
    this.messages,
  });
  final String? name;
  final String? profilePictureUrl;
  final String? status;
  final List<Message>? messages;
}

class Message {
  Message({
    this.text,
    this.isCurrentUser,
  });
  final String? text;
  final bool? isCurrentUser;
}

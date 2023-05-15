import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  bool checkIsTwin() {
    final random = Random();
    var isTwin = false;
    final randomNumber = random.nextInt(10);
    if (randomNumber.isEven) {
      isTwin = true;
    } else {
      isTwin = false;
    }
    return isTwin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(),
            title: const Text('Name'),
            subtitle: Row(
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: checkIsTwin() ? Colors.red : Colors.green,
                ),
                Text(
                  checkIsTwin()
                      ? " Doesn't want to go anywhere"
                      : ' Wants to go somewhere',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

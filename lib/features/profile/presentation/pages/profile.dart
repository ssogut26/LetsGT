import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:letsgt/core/usecases/paddings.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: AppPaddings.pagePadding,
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Name'),
                    Row(
                      children: [
                        const Text('  Status'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            const Row(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text('100 friends'),
                ),
                Text('2 activities'),
              ],
            ),
            const Divider(),
            const Column(
              children: [
                Text('My Activities'),
                Text('App Settings'),
                Text('Log Out'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

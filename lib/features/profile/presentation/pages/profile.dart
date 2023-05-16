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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Card(
                    child: Padding(
                      padding: AppPaddings.textPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('My Activities'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Card(
                    child: Padding(
                      padding: AppPaddings.textPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Feature'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Card(
                    child: Padding(
                      padding: AppPaddings.textPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Feature'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Card(
                    child: Padding(
                      padding: AppPaddings.textPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('App Settings'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Card(
                    child: Padding(
                      padding: AppPaddings.textPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Log Out'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class SignOutNotifier extends ChangeNotifier {
  SignOutNotifier();

  bool isSigningOut = false;
  Future<void> signOut(
    BuildContext context,
    WidgetRef ref,
  ) async {
    isSigningOut = true;
    notifyListeners();
    await MyAuthService()
        .signOut(
      context: context,
      ref: ref,
    )
        .whenComplete(() {
      isSigningOut = false;
      notifyListeners();
    });
  }
}

final signOutProvider = ChangeNotifierProvider(
  (ref) => SignOutNotifier(),
);

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singOut = ref.watch(signOutProvider.notifier);
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
                  child: InkWell(
                    onTap: () {
                      singOut.signOut(context, ref);
                    },
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

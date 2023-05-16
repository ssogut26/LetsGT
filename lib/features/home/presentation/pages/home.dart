import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/activities/presentation/pages/activities.dart';
import 'package:letsgt/features/messages/presentation/pages/messages.dart';
import 'package:letsgt/features/profile/presentation/pages/profile.dart';

class SelectedIndexNotifier extends ChangeNotifier {
  int? selectedPage = 0;
  void changeIndex(int index) {
    selectedPage = index;
    notifyListeners();
  }
}

final selectedIndexProvider = ChangeNotifierProvider(
  (ref) => SelectedIndexNotifier(),
);

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider).selectedPage;
    return Scaffold(
      appBar: AppBar(
        title: [
          const Text('Feed'),
          const Text('Messages'),
          const Text('Activities'),
          const Text('Profile'),
        ][selectedIndex ?? 0],
        actions: [
          if (selectedIndex == 3)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            )
          else
            Container(),
        ],
      ),
      body: [
        const HomeView(),
        const MessagesPage(),
        const ActivitiesPage(),
        const ProfilePage(),
      ][selectedIndex ?? 0],
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              mini: true,
              onPressed: () {
                context.router.push(const CreateActivityRoute());
              },
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.cruelty_free_rounded),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.landscape),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: selectedIndex ?? 0,
        onDestinationSelected: (index) {
          ref.read(selectedIndexProvider).changeIndex(index);
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPaddings.pagePadding,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const PostCard();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: const Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(),
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 20),
                          child: Text('User shared a post\n'),
                        ),
                      ],
                    ),
                    FlutterLogo(
                      size: 240,
                    ),
                    Text('Title'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

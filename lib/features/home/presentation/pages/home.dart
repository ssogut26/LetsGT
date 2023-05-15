import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';

/// With RoutePage annotation, this class will generate
/// the route information and add it to the app's router.
/// This is home page
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        mini: true,
        onPressed: () {
          context.router.push(const CreateActivityRoute());
        },
        child: const Icon(Icons.add),
      ),
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
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.router.push(const HomeRoute());
              break;
            case 1:
              context.router.push(const MessagesRoute());
              break;
            case 2:
              context.router.push(const ActivitiesRoute());
              break;
            case 3:
              context.router.push(const ProfileRoute());
              break;
            default:
              context.router.push(const SignInRoute());
              break;
          }
        },
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

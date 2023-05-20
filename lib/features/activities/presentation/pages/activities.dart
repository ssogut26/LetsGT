import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';
import 'package:letsgt/models/ModelProvider.dart';

final activitiesProvider = FutureProvider.autoDispose(
  (
    ref,
  ) async {
    await MyAuthService().fetchActivities();
  },
);

@RoutePage()
class ActivitiesPage extends ConsumerWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activitiesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(CreateActivityRoute());
        },
        child: const Icon(Icons.add),
      ),
      body: activities.when(
        error: (error, stackTrace) => const Center(
          child: Text('Error'),
        ),
        data: (data) {
          print(data);
          if (data is ActivityModel) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(data.activityName),
                  subtitle: const Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.red,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       leading: const CircleAvatar(),
      //       title: const Text('Name'),
      //       subtitle: Row(
      //         children: [
      //           CircleAvatar(
      //             radius: 4,
      //             backgroundColor: checkIsTwin() ? Colors.red : Colors.green,
      //           ),
      //           Text(
      //             checkIsTwin()
      //                 ? " Doesn't want to go anywhere"
      //                 : ' Wants to go somewhere',
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

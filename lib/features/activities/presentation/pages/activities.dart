import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';
import 'package:letsgt/models/ActivityModel.dart';

final activitiesProvider = FutureProvider<List<ActivityModel?>>(
  (
    ref,
  ) async {
    final result = await MyAuthService().fetchActivities();
    return result;
  },
);

final activityIdProvider = StateProvider<String>((ref) {
  return '';
});

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
        data: (List<ActivityModel?> data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final activityDetails = data[index];
              return InkWell(
                onTap: () {
                  ref.read(activityIdProvider.notifier).state =
                      activityDetails?.id ?? '';
                  context.router.push(
                    const ActivityDetailRoute(),
                  );
                },
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(activityDetails?.activityName ?? ''),
                  subtitle: Row(
                    children: [
                      // Text(
                      //   activityDetails?.activityDescription ?? 'ss',
                      // ),
                      Text(
                        activityDetails?.createdBy ?? '',
                      ),
                      // Text(
                      //   activityDetails?.selectedDate ?? 'ss',
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
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

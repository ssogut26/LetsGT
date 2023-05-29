import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/features/activities/data/repository/activity_repository_impl.dart';
import 'package:letsgt/models/ActivityModel.dart';

final activitiesProvider = FutureProvider<List<ActivityModel?>>(
  (
    ref,
  ) async {
    final result = await ActivityRepositoryImpl().getActivities();
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
        error: (error, stackTrace) => Center(
          child: Text('Error$stackTrace'),
        ),
        data: (List<ActivityModel?> data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(activitiesProvider);
            },
            child: ListView.builder(
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
                        Text(
                          activityDetails?.createdBy ?? '',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

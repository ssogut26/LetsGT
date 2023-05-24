import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/activities/presentation/pages/activities.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';
import 'package:letsgt/models/ActivityModel.dart';

final activityDetailProvider =
    FutureProvider.family<ActivityModel?, ActivityModel>((ref, id) async {
  final result = await MyAuthService().getActivityDetails(
    id,
  );
  return result;
});

@RoutePage()
class ActivityDetailPage extends ConsumerWidget {
  const ActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityDetails = ref.watch(
      activityDetailProvider(
        ActivityModel(
          id: ref.watch(activityIdProvider.notifier).state,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Detail'),
      ),
      body: activityDetails.when(
        error: (error, stackTrace) => const Center(
          child: Text('Error'),
        ),
        data: (ActivityModel? data) {
          return ListView(
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(data?.activityName ?? ''),
                subtitle: Text(data?.activityDescription ?? ''),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

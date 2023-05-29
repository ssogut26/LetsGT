import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:letsgt/features/activities/data/repository/activity_repository_impl.dart';
import 'package:letsgt/features/activities/presentation/pages/activities.dart';
import 'package:letsgt/features/auth/presentation/pages/confirm_reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/models/ModelProvider.dart';

final activityDetailProvider =
    FutureProvider.family<ActivityModel?, ActivityModel>((ref, id) async {
  final result = await ActivityRepositoryImpl().getActivityDetails(
    id,
  );
  return result;
});

// remove activity provider
final deleteActivityProvider =
    FutureProvider.family<ActivityModel?, ActivityModel>(
  (ref, id) async {
    final result = await ActivityRepositoryImpl().deleteActivityById(
      id,
    );
    return result;
  },
);

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
    final deleteActivity = ref.watch(
      deleteActivityProvider(
        ActivityModel(
          id: ref.watch(activityIdProvider.notifier).state,
        ),
      ),
    );
  

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Detail'),
        actions: [
          IconButton(
            onPressed: () async {
              await ActivityRepositoryImpl().deleteActivityById(
                ActivityModel(
                  id: ref.watch(activityIdProvider.notifier).state,
                ),
              );
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: activityDetails.when(
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $stackTrace',
          ),
        ),
        data: (ActivityModel? data) {
          final locationDetails = data?.selectedLocation;
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.tryParse(locationDetails?.latitude ?? '') ?? 0.0,
                      double.tryParse(locationDetails?.longitude ?? '') ?? 0.0,
                    ),
                    zoom: 17,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(
                        locationDetails?.fullLocation ?? '',
                      ),
                      position: LatLng(
                        double.tryParse(locationDetails?.latitude ?? '') ?? 0.0,
                        double.tryParse(locationDetails?.longitude ?? '') ??
                            0.0,
                      ),
                    ),
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity Name',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(data?.activityName ?? ''),
                    Text(
                      'Activity Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(data?.activityDescription ?? ''),
                    Text(
                      'Activity Date',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(
                        DateTime.tryParse(
                              data?.selectedDate.toString() ?? '',
                            ) ??
                            DateTime.now(),
                      ),
                    ),
                    Text(
                      'Activity Location',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      locationDetails?.fullLocation ?? '',
                      maxLines: 3,
                    ),
                    Text(
                      'Participants',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.participants?.length ?? 0,
                        itemBuilder: (context, index) {
                          final participantDetails = data?.participants?[index];
                          return Column(
                            children: [
                              const CircleAvatar(),
                              Text(participantDetails ?? ''),
                            ],
                          );
                        },
                      ),
                    ),
                    resizableHeightBox(context),
                    Center(
                      child: AppElevatedButton(
                        text: 'Ask for join',
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
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

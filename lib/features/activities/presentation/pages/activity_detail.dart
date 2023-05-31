import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:letsgt/core/usecases/environment_variables.dart';
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

class BigMapNotifier extends ChangeNotifier {
  bool isBigMap = false;

  void changeMapSize() {
    isBigMap = !isBigMap;
    notifyListeners();
  }
}

final bigMapProvider = ChangeNotifierProvider<BigMapNotifier>((ref) {
  return BigMapNotifier();
});

@RoutePage()
class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({super.key});

  @override
  ConsumerState<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  PolylinePoints? polylinePoints;

// List of coordinates to join
  List<LatLng>? polylineCoordinates = [];

// Map storing polylines created by connecting
// two points
  Map<PolylineId, Polyline>? polylines = {};
  double distance = 0;
  Future<void> setRoute(
    String? destinationLatitude,
    String? destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    final currentPosition = await Geolocator.getCurrentPosition();
    final result = await polylinePoints?.getRouteBetweenCoordinates(
      EnvironmentVariables.mapsApiKey, // Google Maps API Key
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(
        double.tryParse(destinationLatitude ?? '') ?? 0.0,
        double.tryParse(destinationLongitude ?? '') ?? 0.0,
      ),
      travelMode: TravelMode.transit,
    );
    distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      double.tryParse(destinationLatitude ?? '') ?? 0.0,
      double.tryParse(destinationLongitude ?? '') ?? 0.0,
    );

    // Adding the coordinates to the list
    if (result?.points.isNotEmpty ?? false) {
      for (final point in result!.points) {
        polylineCoordinates?.add(LatLng(point.latitude, point.longitude));
      }
    }

    // Defining an ID
    const id = PolylineId('poly');

    // Initializing Polyline
    final polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates ?? [],
      width: 4,
      patterns: [
        PatternItem.dash(20),
        PatternItem.gap(10),
      ],
      consumeTapEvents: true,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      geodesic: true,
      jointType: JointType.round,
      onTap: () {},
      visible: true,
      zIndex: 1,
    );

    // Adding the polyline to the map
    setState(() {
      polylines?[id] = polyline;
    });
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final activityDetails = ref.watch(
      activityDetailProvider(
        ActivityModel(
          id: ref.watch(activityIdProvider.notifier).state,
        ),
      ),
    );
    final bigMapNotifier = ref.watch(bigMapProvider);
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
      bottomSheet: distance == 0
          ? const SizedBox.shrink()
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              width: double.infinity,
              child: Center(
                child: Text(
                  distance > 1000
                      ? 'Distance ${(distance / 1000).toStringAsFixed(1)} km'
                      : 'Distance ${distance.toStringAsFixed(0)} m',
                ),
              ),
            ),
      body: activityDetails.when(
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $stackTrace',
          ),
        ),
        data: (ActivityModel? data) {
          final locationDetails = data?.selectedLocation;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: double.infinity,
                height: bigMapNotifier.isBigMap
                    ? MediaQuery.of(context).size.height * 0.85
                    : MediaQuery.of(context).size.height * 0.25,
                child: GoogleMap(
                  myLocationEnabled: true,
                  onTap: (latLng) {
                    bigMapNotifier.changeMapSize();
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.tryParse(locationDetails?.latitude ?? '') ?? 0.0,
                      double.tryParse(locationDetails?.longitude ?? '') ?? 0.0,
                    ),
                    zoom: 17,
                  ),
                  polylines: Set<Polyline>.of(polylines?.values ?? []),
                  markers: {
                    Marker(
                      markerId: MarkerId(
                        locationDetails?.fullLocation ?? '',
                      ),
                      onTap: () async {
                        if (polylineCoordinates?.isNotEmpty ?? false) {
                          polylineCoordinates?.clear();
                        }
                        await setRoute(
                          locationDetails?.latitude ?? '',
                          locationDetails?.longitude ?? '',
                        );
                      },
                      position: LatLng(
                        double.tryParse(locationDetails?.latitude ?? '') ?? 0.0,
                        double.tryParse(locationDetails?.longitude ?? '') ??
                            0.0,
                      ),
                    ),
                  },
                ),
              ),
              if (bigMapNotifier.isBigMap)
                const SizedBox()
              else
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
                            final participantDetails =
                                data?.participants?[index];
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

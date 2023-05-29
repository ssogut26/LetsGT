import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/features/activities/domain/repository/activity_repository.dart';
import 'package:letsgt/models/ActivityModel.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  @override
  Future<ActivityModel?> deleteActivityById(
    ActivityModel deleteActivityById,
  ) async {
    try {
      await Amplify.DataStore.delete(deleteActivityById);

      // final request = ModelMutations.deleteById(
      //   ActivityModel.classType,
      //   ActivityModelModelIdentifier(
      //     id: deleteActivityById.id,
      //   ),
      // );
      // final response = await Amplify.API.mutate(request: request).response;
      // final deletedActivity = response.data;
      // if (deletedActivity == null) {
      //   safePrint('errors: ${response.errors}');
      // }
      // return deletedActivity;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
    return null;
  }

  @override
  Future<List<ActivityModel?>> getActivities() async {
    try {
      final request = ModelQueries.list(ActivityModel.classType);
      final response = await Amplify.API.query(request: request).response;

      final activities = response.data?.items;
      if (activities == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      activities.sort(
        (a, b) =>
            a!.createdAt?.compareTo(
              b!.createdAt!,
            ) ??
            0,
      );
      return activities;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  @override
  Future<ActivityModel?> getActivityDetails(
    ActivityModel queriedActivity,
  ) async {
    try {
      final request = ModelQueries.get(
        ActivityModel.classType,
        queriedActivity.modelIdentifier,
      );

      final response = await Amplify.API.query(request: request).response;

      final activity = response.data;
      if (activity == null) {
        safePrint('errors: ${response.errors}');
      }
      return activity;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return null;
    }
  }
}

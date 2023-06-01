import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/features/create_activity/domain/repository/create_activity_repository.dart';
import 'package:letsgt/models/ActivityModel.dart';
import 'package:letsgt/models/LocationModel.dart';

class CreateActivityRepositoryImpl implements CreateActivityRepository {
  @override
  Future<void> createActivity({
    required String activityName,
    required String activityDescription,
    required TemporalDateTime selectedDate,
    required LocationModel? selectedLocation,
    String? createdBy,
  }) async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userName = attributes
          .firstWhere((element) => element.userAttributeKey.key == 'name')
          .value;
      final randomId = Random().nextInt(10000);
      final activityData = ActivityModel(
        id: randomId.toString(),
        activityDescription: activityDescription,
        activityName: activityName,
        selectedDate: selectedDate,
        selectedLocation: selectedLocation,
        participants: const ['Selcuk'],
        createdBy: userName,
      );
      final request = ModelMutations.create(
        activityData,
      );

      final response = await Amplify.API.mutate(request: request).response;

      final createdActivityData = response.data;

      if (createdActivityData == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdActivityData.activityName}');
    } on ApiException catch (e) {
      safePrint('Error creating activity: ${e.message}');
    }
  }
}

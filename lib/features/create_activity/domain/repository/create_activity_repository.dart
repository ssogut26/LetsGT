import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:letsgt/models/LocationModel.dart';

abstract class CreateActivityRepository {
  Future<void> createActivity({
    required String activityName,
    required String activityDescription,
    required TemporalDateTime selectedDate,
    required LocationModel? selectedLocation,
    String? createdBy,
  });
}

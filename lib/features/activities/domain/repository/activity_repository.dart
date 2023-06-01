import 'package:letsgt/models/ModelProvider.dart';

abstract class ActivityRepository {
  Future<List<ActivityModel?>> getActivities();
  Future<ActivityModel?> getActivityDetails(
    ActivityModel queriedActivity,
  );

  Future<ActivityModel?> deleteActivityById(
    ActivityModel deleteActivityById,
  );
}

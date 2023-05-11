import 'dart:convert';

import 'package:letsgt/features/create_activity/domain/usecases/auto_complete_prediction.dart';

class PlaceAutoCompleteResponse {
  PlaceAutoCompleteResponse({this.status, this.predictions});

  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? (json['predictions'] as List<dynamic>)
              .map(
                (e) => AutoCompletePrediction.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }
  final String? status;
  final List<AutoCompletePrediction>? predictions;

  static PlaceAutoCompleteResponse parseAutoCompleteResult(String response) {
    final parsedBody = json.decode(response);
    return PlaceAutoCompleteResponse.fromJson(
      parsedBody as Map<String, dynamic>,
    );
  }
}

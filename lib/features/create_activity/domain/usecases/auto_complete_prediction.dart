class AutoCompletePrediction {
  AutoCompletePrediction({
    this.description,
    this.placeId,
    this.structuredFormatting,
    this.reference,
  });

  factory AutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutoCompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(
              json['structured_formatting'] as Map<String, dynamic>,
            )
          : null,
      reference: json['reference'] as String?,
    );
  }
  final String? description;
  final String? placeId;
  final StructuredFormatting? structuredFormatting;
  final String? reference;
}

class StructuredFormatting {
  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
  final String? mainText;
  final String? secondaryText;
}

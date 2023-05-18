import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkEntities {
  Future<String>? searchByQuery(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return 'We have an error';
  }
}

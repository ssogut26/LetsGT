import 'package:amplify_flutter/amplify_flutter.dart';

class AuthUseCases {
  Future<String> getUserName() async {
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final userName = attributes
        .firstWhere((element) => element.userAttributeKey.key == 'name')
        .value;
    return userName;
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentVariables {
  static String get clientId => dotenv.env['APP_CLIENT_ID'] ?? '';
  static String get cognitoIdentityPoolId =>
      dotenv.env['COGNITO_IDENTITY_POOL_ID'] ?? '';
  static String get cognitoUserPoolId =>
      dotenv.env['COGNITO_USER_POOL_ID'] ?? '';
  static String get endpoint => dotenv.env['GRAPHQL_ENDPOINT'] ?? '';
}

import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/amplifyconfiguration.dart';
import 'package:letsgt/app.dart';
import 'package:letsgt/models/ModelProvider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    mergeWith: Platform.environment,
  );
  await FlutterConfigPlus.loadEnvVariables();
  await _configureAmplify();
  await Permission.locationWhenInUse.request();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _configureAmplify() async {
  try {
    // Add Amplify Plugins
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyStorageS3(),
      AmplifyAPI(
        modelProvider: ModelProvider.instance,
      )
    ]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

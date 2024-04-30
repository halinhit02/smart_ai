import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/binding/app_binding.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/helpers/text_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: GetPlatform.isIOS
        ? DefaultFirebaseOptions.ios
        : DefaultFirebaseOptions.android,
  );
  // Setup firebase remote config
  var remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 10),
      minimumFetchInterval: const Duration(hours: 12)));
  await remoteConfig.setDefaults(AppConfig.defaultParameters);
  remoteConfig.fetchAndActivate();
  remoteConfig.onConfigUpdated.listen((event) async {
    await remoteConfig.activate();
  });
  // Set OpenAI API key
  OpenAI.apiKey = "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";
  // Gemini init
  Gemini.init(apiKey: 'AIzaSyCAC-yAcj8qGc4CxEkg7aF_svabt5gZWJg');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart AI',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        textTheme: myTextTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0277BD),
        ),
        useMaterial3: true,
      ),
      initialBinding: AppBinding(prefs: sharedPreferences),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.homeRoute,
    );
  }
}

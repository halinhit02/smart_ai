import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:smart_ai/helper/text_theme.dart';
import 'package:smart_ai/util/app_routes.dart';

void main() {
  Gemini.init(
      apiKey: 'AIzaSyCAC-yAcj8qGc4CxEkg7aF_svabt5gZWJg',
      generationConfig: GenerationConfig(
        temperature: 0.9,
        maxOutputTokens: 5000,
      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        textTheme: myTextTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue.shade900,
        ),
        useMaterial3: true,
      ),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.welcomeRoute,
    );
  }
}

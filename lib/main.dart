import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/config/theme_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: getPages,
        debugShowCheckedModeBanner: false,
        title: 'MathQuiz',
        theme: AppTheme.lightTheme(),
        initialRoute: Routes.loginScreen);
  }
}

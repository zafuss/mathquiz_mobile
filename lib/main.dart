import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/config/theme_const.dart';
import 'package:mathquiz_mobile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

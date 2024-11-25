import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/config/theme_const.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Khởi tạo AuthController và refresh token trước khi chạy ứng dụng
  final AuthController authController = Get.put(AuthController());
  await authController.refreshToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return GetMaterialApp(
      getPages: getPages,
      debugShowCheckedModeBanner: false,
      title: 'MathQuiz',
      theme: AppTheme.lightTheme(),
      initialRoute: authController.isLoggedIn.value
          ? Routes.homeScreen
          : Routes.loginScreen,
    );
  }
}

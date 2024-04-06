import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/screens/screens.dart';

class Routes {
  static String welcomeScreen = '/welcome';
  static String loginScreen = '/login';
  static String registerScreen = '/register';
  static String forgotPasswordScreen = '/forgotPassword';
  static String otpScreen = '/otpScreen';
  static String homeScreen = '/homeScreen';
}

final getPages = [
  GetPage(name: Routes.welcomeScreen, page: () => const WelcomeScreen()),
  GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
  GetPage(name: Routes.registerScreen, page: () => const RegisterScreen()),
  GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen()),
  GetPage(name: Routes.otpScreen, page: () => const OtpScreen()),
  GetPage(name: Routes.homeScreen, page: () => const HomeScreen()),
];

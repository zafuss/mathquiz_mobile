import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/screens/screens.dart';

class Routes {
  static String welcomeScreen = '/welcome';
  static String loginScreen = '/login';
  static String registerScreen = '/register';
  static String forgotPasswordScreen = '/forgotPassword';
  static String otpScreen = '/otpScreen';
  static String homeScreen = '/homeScreen';
  static String chooseExamConditionScreen = '/chooseExamConditonScreen';
  static String examStartScreen = '/examStartScreen';
  static String doExamScreen = '/doExamScreen';
  static String resultScreen = '/resultScreen';
  static String reviewExamScreen = '/reviewExamScreen';
  static String reviewExamDetailScreen = '/reviewExamDetailScreen';
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
  GetPage(
      name: Routes.chooseExamConditionScreen,
      page: () => const ChooseExamConditionScreen()),
  GetPage(name: Routes.examStartScreen, page: () => const ExamStartScreen()),
  GetPage(name: Routes.doExamScreen, page: () => const DoExamScreen()),
  GetPage(name: Routes.resultScreen, page: () => const ResultScreen()),
  GetPage(name: Routes.reviewExamScreen, page: () => const ReviewExamScreen()),
  GetPage(
      name: Routes.reviewExamDetailScreen,
      page: () => const ReviewExamDetailScreen()),
];

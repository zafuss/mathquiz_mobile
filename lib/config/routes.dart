import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/screens/auth_screens/personal_information_screen.dart';
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
  static String examHistoryScreen = '/examHistoryScreen';
  static String resetPasswordScreen = '/resetPasswordScreen';
  static String personalInformationScreen = '/personalInformationScreen';
  static String aboutScreen = '/aboutScreen';
  static String classroomIndexScreen = '/classroomIndexScreen';
  static String myClassroomsScreen = '/myClassroomsScreen';
  static String myJoinedClassroomsScreen = '/myJoinedClassroomsScreen';
  static String classroomScreen = '/classroomScreen';
  static String classroomMembersScreen = '/classroomMembersScreen';
  static String classroomNewsScreen = '/classroomNewsScreen';
  static String classroomChooseExamScreen = '/classroomChooseExamScreen';
  static String classroomExamStartScreen = '/classroomExamStartScreen';
  static String classroomResultScreen = '/classroomResultScreen';
  static String classroomHomeworkResultsScreen =
      '/classroomHomeworkResultsScreen';
  static String classroomHomeworkBestResultsScreen =
      '/classroomHomeworkBestResultsScreen';
  static String classroomHomeworkListScreen = '/classroomHomeworkListScreen';
  static String classroomEditHomeworkScreen = '/classroomEditHomeworkScreen';
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
  GetPage(name: Routes.doExamScreen, page: () => DoExamScreen()),
  GetPage(name: Routes.resultScreen, page: () => const ResultScreen()),
  GetPage(name: Routes.reviewExamScreen, page: () => const ReviewExamScreen()),
  GetPage(
      name: Routes.reviewExamDetailScreen,
      page: () => const ReviewExamDetailScreen()),
  GetPage(
      name: Routes.examHistoryScreen, page: () => const ExamHistoryScreen()),
  GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen()),
  GetPage(
      name: Routes.personalInformationScreen,
      page: () => const PersonalInformationScreen()),
  GetPage(name: Routes.aboutScreen, page: () => const AboutScreen()),
  GetPage(
      name: Routes.classroomIndexScreen,
      page: () => const ClassroomIndexScreen()),
  GetPage(
      name: Routes.myClassroomsScreen, page: () => const MyClassroomsScreen()),
  GetPage(
      name: Routes.myJoinedClassroomsScreen,
      page: () => const MyJoinedClassroomsScreen()),
  GetPage(name: Routes.classroomScreen, page: () => ClassroomScreen()),
  GetPage(
      name: Routes.classroomMembersScreen,
      page: () => const ClassroomMembersScreen()),
  GetPage(name: Routes.classroomNewsScreen, page: () => ClassroomNewsScreen()),
  GetPage(
      name: Routes.classroomChooseExamScreen,
      page: () => const ClassroomChooseExamScreen()),
  GetPage(
      name: Routes.classroomExamStartScreen,
      page: () => const ClassroomExamStartScreen()),
  GetPage(
      name: Routes.classroomResultScreen,
      page: () => const ClassroomResultScreen()),
  GetPage(
      name: Routes.classroomHomeworkResultsScreen,
      page: () => const ClassroomHomeworkResultScreen()),
  GetPage(
      name: Routes.classroomHomeworkBestResultsScreen,
      page: () => const ClassroomHomeworkBestResultScreen()),
  GetPage(
      name: Routes.classroomHomeworkListScreen,
      page: () => const ClassroomHomeworkListScreen()),
  GetPage(
      name: Routes.classroomEditHomeworkScreen,
      page: () => const ClassroomEditHomeworkScreen()),
];

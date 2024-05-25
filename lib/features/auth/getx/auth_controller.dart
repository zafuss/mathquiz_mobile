import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import '../../../result_type.dart';
import '../data/auth_repository.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isUploadingAvatar = false.obs;
  var isRememberMe = false.obs;
  var isChangingInformation = false.obs;
  final authRepository = AuthRepository();
  var isRegisterSuccess = false.obs;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await authRepository.login(email: email, password: password);
    isLoading.value = false;
    switch (result) {
      case Success():
        Get.offAndToNamed(Routes.homeScreen);
        break;
      case Failure():
        Get.snackbar('Đăng nhập thất bại', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> register(String email, String password, String fullName) async {
    isLoading.value = true;
    final result = await authRepository.register(
        email: email, password: password, fullName: fullName);
    switch (result) {
      case Success():
        isLoading.value = false;
        isRegisterSuccess.value = true;
        Get.snackbar('Đăng ký thành công!', 'Chào mừng bạn đến với MathQuiz');

        break;
      case Failure():
        isLoading.value = false;
        isRegisterSuccess.value = false;
        Get.snackbar('Đăng ký thất bại', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    switch (result) {
      case Success():
        isLoading.value = false;
        Get.snackbar('Thông báo', 'Đổi mật khẩu thành công!');
        break;
      case Failure():
        isLoading.value = false;
        Get.snackbar('Lỗi cập nhật mật khẩu', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> resetPasswordWithOtp(
    String otp,
    String password,
  ) async {
    isLoading.value = true;
    final result =
        await authRepository.resetPasswordWithOtp(otp: otp, password: password);
    switch (result) {
      case Success():
        isLoading.value = false;
        Get.snackbar('Thông báo', 'Đổi mật khẩu thành công!');
        Get.offAndToNamed(Routes.loginScreen);
        break;
      case Failure():
        isLoading.value = false;
        Get.snackbar('Lỗi cập nhật mật khẩu', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> sendForgotPasswordEmail(String email) async {
    isLoading.value = true;
    final result = await authRepository.sendForgotPasswordEmail(email: email);
    switch (result) {
      case Success():
        isLoading.value = false;
        Get.toNamed(Routes.resetPasswordScreen);
        Get.snackbar('Thông báo', 'Đã gửi OTP đến địa chỉ email của bạn.');
        break;
      case Failure():
        isLoading.value = false;
        Get.snackbar('Lỗi', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> verifyOtp(String id, String otp) async {
    isLoading.value = true;
    final result = await authRepository.verifyOtp(id: id, otp: otp);
    switch (result) {
      case Success():
        isLoading.value = false;
        isRegisterSuccess.value = true;
        Get.snackbar('Xác thực OTP thành công!',
            'Vui lòng đăng nhập để sử dụng MathQuiz.');
        await Future.delayed(const Duration(seconds: 3));
        toLogin();
        break;
      case Failure():
        isLoading.value = false;
        isRegisterSuccess.value = false;
        Get.snackbar(
            'OTP không đúng hoặc tài khoản đã được kích hoạt trước đó.',
            result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  void toLogin() {
    isRegisterSuccess = false.obs;
    Get.offAndToNamed(Routes.loginScreen);
  }

  void toOtp() {
    isRegisterSuccess = false.obs;
    Get.offAndToNamed(Routes.otpScreen);
  }

  Future<void> processRegisterSuccess() async {}

  void toRegister() {
    Get.toNamed(Routes.registerScreen);
  }

  void toForgotPassword() {}

  void loginByGoogle() {}

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await uploadImage(_image!);
    }
  }

  Future<void> uploadImage(File image) async {
    isUploadingAvatar.value = true;
    final result = await authRepository.uploadAvatar(file: image);
    switch (result) {
      case Success():
        isUploadingAvatar.value = false;
        isRegisterSuccess.value = true;
        Get.snackbar('Thành công', 'Cập nhật ảnh đại diện thành công.');
        break;
      case Failure():
        isUploadingAvatar.value = false;
        isRegisterSuccess.value = false;
        Get.snackbar('Lỗi.', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  Future<void> updatePersonalInformation(
      String? fullName, String? phoneNumber, int? gradeId) async {
    isLoading.value = true;
    final result = await authRepository.updatePersonalInformation(
        fullName: fullName, phoneNumber: phoneNumber, gradeId: gradeId);
    switch (result) {
      case Success():
        isLoading.value = false;
        Get.snackbar('Thành công', 'Cập nhật thông tin cá nhân thành công.');
        break;
      case Failure():
        isLoading.value = true;
        Get.snackbar('Lỗi.', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }
}

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Rx<User?> user = Rx<User?>(null);
  File? _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((event) {
      user.value = event;
    });

    // TODO: implement onInit
  }

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
        // isRegisterSuccess.value = true;
        Get.toNamed(Routes.otpScreen);
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

  Future<void> loginByGoogle() async {
    try {
      isLoading.value = true;
      await auth.signOut();
      await _callGoogleDialog();
      print(user.value);
      if (user.value != null) {
        final result =
            await authRepository.loginByEmail(email: user.value!.email!);
        isLoading.value = false;
        if (result is Success) {
          isLoading.value = false;
          Get.offAndToNamed(Routes.homeScreen);
        } else if (result is Failure) {
          isLoading.value = false;
          if (result.statusCode == 400) {
            Get.toNamed(Routes.registerScreen);
            Get.snackbar(
                'Lỗi đăng nhập', 'Tài khoản chưa tồn tại, vui lòng đăng ký');
          } else if (result.statusCode == 401) {
            Get.snackbar('Lỗi đăng nhập',
                'Tài khoản cần xác minh email. Vui lòng kiểm tra mã OTP hộp thư đến.');
            Get.toNamed(Routes.otpScreen);
          } else {
            Get.snackbar('Lỗi đăng nhập', 'Có lỗi xảy ra');
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Lỗi', e.toString());
    }
  }

  Future<void> _callGoogleDialog() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if user cancelled the dialog
      if (googleUser == null) {
        // Handle cancellation
        return; // Exit function
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    }
  }

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

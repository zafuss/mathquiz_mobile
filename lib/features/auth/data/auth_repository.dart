import 'dart:io';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/auth_api_client.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/dtos/change_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/register_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/reset_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/upload_avatar_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/verify_otp_dto.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../dtos/login_dto.dart';

class AuthRepository {
  final authApiClient = AuthApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginSuccessDto = await authApiClient.login(
        LoginDto(email: email, password: password, rememberMe: true),
      );
      await localDataController.saveClientId(loginSuccessDto.id);
      await localDataController.saveClientEmail(loginSuccessDto.email);
      await localDataController
          .saveClientFullName(loginSuccessDto.fullName ?? 'null');
      await localDataController
          .saveClientImageUrl(loginSuccessDto.avatarUrl ?? '');
      await localDataController
          .saveClientAccessToken(loginSuccessDto.accessToken);
      await localDataController
          .saveClientRefreshToken(loginSuccessDto.refreshToken);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> register(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      final registerSuccessDto = await authApiClient.register(
        RegisterDto(email: email, password: password, fullName: fullName),
      );
      await localDataController.saveRegisterClientId(registerSuccessDto.id);
      await localDataController.saveClientEmail(registerSuccessDto.email);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> verifyOtp({
    required String id,
    required String otp,
  }) async {
    try {
      await authApiClient.verifyOtp(
        VerifyOtpDto(
          userId: id,
          otp: otp,
        ),
      );
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      var id = localDataController.clientId.value;
      print(id);
      await authApiClient.changePassword(
        ChangepasswordDto(
            userId: id,
            currentPassword: currentPassword,
            newPassword: newPassword),
      );
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> resetPasswordWithOtp(
      {required String otp, required String password}) async {
    try {
      var email = localDataController.clientEmail.value;
      print(email);
      await authApiClient.resetPasswordWithOtp(
          ResetPasswordDto(email: email, otp: otp, password: password));
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> sendForgotPasswordEmail(
      {required String email}) async {
    try {
      await authApiClient.sendForgotPasswordEmail(email);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> uploadAvatar({required File file}) async {
    try {
      final token = await localDataController.getClientAccessToken();
      final imageUrl = await authApiClient.updateAvatar(
          file,
          UploadAvatarDto(
              userId: localDataController.clientId.value, imageUrl: null),
          token!);
      await localDataController.saveClientImageUrl(imageUrl);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> logout() async {
    try {
      await localDataController.deleteClientEmail();
      await localDataController.deleteClientId();
      await localDataController.deleteClientFullName();
      await localDataController.deleteRegisterClientId();
      await localDataController.deleteClientImageUrl();
      return Success(null);
    } catch (e) {
      return Failure('$e');
    }
  }
}

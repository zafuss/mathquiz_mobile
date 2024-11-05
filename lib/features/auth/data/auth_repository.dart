import 'dart:io';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/auth_api_client.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/dtos/change_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/login_success_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/register_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/reset_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/update_personal_information_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/upload_avatar_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/verify_otp_dto.dart';
import 'package:mathquiz_mobile/helpers/api_custom_exception.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../dtos/login_dto.dart';

class AuthRepository {
  final authApiClient = AuthApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<void>> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    LoginSuccessDto? loginSuccessDto; // Sử dụng kiểu nullable
    try {
      loginSuccessDto = await authApiClient.login(
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
      await localDataController
          .saveClientPhoneNumber(loginSuccessDto.phoneNumber ?? '');
      await localDataController
          .saveClientGradeId(loginSuccessDto.gradeId ?? -1);
      await localDataController.saveIsRememberMe(isRememberMe);
    } catch (e) {
      if (e is ApiCustomException) {
        await localDataController.saveClientEmail(email);
        // Kiểm tra nếu loginSuccessDto đã khởi tạo trước khi sử dụng
        if (loginSuccessDto != null) {
          await localDataController.saveRegisterClientId(loginSuccessDto.id);
        }
        return Failure(e.message, e.statusCode);
      }
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> loginByEmail(
      {required String email, required bool isRememberMe}) async {
    try {
      await localDataController.saveClientEmail(email);
      final result = await authApiClient.loginByEmail(email);
      if (result is Success<LoginSuccessDto>) {
        final loginSuccessDto = result.data;
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
        await localDataController
            .saveClientPhoneNumber(loginSuccessDto.phoneNumber ?? '');
        await localDataController
            .saveClientGradeId(loginSuccessDto.gradeId ?? -1);
        await localDataController.saveIsRememberMe(isRememberMe);
        return result; // Return the Success result
      } else if (result is Failure<LoginSuccessDto>) {
        // Handle failure
        await localDataController.saveClientId(result.message);
        return result; // Return the Failure result
      } else {
        // Handle other cases
        return Failure('Unknown error');
      }
    } catch (e) {
      return Failure('Unknown error');
    }
  }

  Future<ResultType<void>> register(
      {required String email,
      required String password,
      required String fullName,
      required int gradeId}) async {
    try {
      final registerSuccessDto = await authApiClient.register(
        RegisterDto(
            email: email,
            password: password,
            fullName: fullName,
            gradeId: gradeId),
      );
      await localDataController.saveRegisterClientId(registerSuccessDto.id);
      await localDataController.saveClientEmail(registerSuccessDto.email);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await authApiClient.verifyOtp(
        VerifyOtpDto(
          email: email,
          otp: otp,
        ),
      );
      await localDataController.deleteClientEmail();
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<ResultType<void>> refreshToken() async {
    try {
      final token = await localDataController.getClientRefreshToken();
      final isRememberMe = await localDataController.getIsRememberMe();
      if (isRememberMe!) {
        final dto = await authApiClient.refreshToken(token);
        if (dto != null) {
          localDataController.saveClientAccessToken(dto.accessToken);
          localDataController.saveClientEmail(dto.email);
          localDataController.saveClientFullName(dto.fullName);
          localDataController.saveClientGradeId(dto.gradeId ?? -1);
          localDataController.saveClientId(dto.userId);
          localDataController.saveClientImageUrl(dto.imageUrl ?? "");
          localDataController.saveClientRefreshToken(dto.refreshToken);
          localDataController.saveClientPhoneNumber(dto.phoneNumber ?? "");
        }
      } else {
        return Failure('remember me is off');
      }
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

  Future<ResultType<void>> resendOTP({required String email}) async {
    try {
      await authApiClient.resendOTP(email);
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

  Future<ResultType<void>> updatePersonalInformation(
      {String? fullName, String? phoneNumber, int? gradeId}) async {
    try {
      final id = await localDataController.getClientId();
      await authApiClient.updatePersonalInformation(
        UpdatePersonalInformationDto(
            id: id!,
            fullName: fullName,
            phoneNumber: phoneNumber,
            gradeId: gradeId),
      );
      await localDataController.saveClientGradeId(gradeId ?? -1);
      await localDataController.saveClientFullName(fullName ?? 'null');
      await localDataController.saveClientPhoneNumber(phoneNumber ?? '');
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }
  // Future<ResultType<void>> loginByGoogle(
  //     ) async {
  //   try {

  //   } catch (e) {
  //     return Failure('$e');
  //   }
  //   return Success(null);
  // }

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

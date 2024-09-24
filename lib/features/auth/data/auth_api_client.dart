import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/dtos/reset_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/token_refresh_success_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/update_personal_information_dto.dart';
import 'package:mathquiz_mobile/helpers/api_custom_exception.dart';
import 'package:mathquiz_mobile/result_type.dart';
import '../../../config/http_client.dart';
import '../dtos/change_password_dto.dart';
import '../dtos/login_dto.dart';
import '../dtos/login_success_dto.dart';
import '../dtos/register_success_dto.dart';
import '../dtos/upload_avatar_dto.dart';
import '../dtos/verify_otp_dto.dart';
import '../dtos/register_dto.dart';

class AuthApiClient {
  final DioClient dioClient = DioClient();

  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dioClient.dio.post(
        'account/login/',
        data: loginDto.toJson(),
      );
      print(response);
      final loginSuccessDto = LoginSuccessDto.fromJson(response.data);
      return loginSuccessDto;
    } on DioException catch (e) {
      throw ApiCustomException(
          message: e.response != null ? e.response!.data : e.message,
          statusCode: e.response!.statusCode);
    }
  }

  Future<ResultType<LoginSuccessDto>> loginByEmail(String email) async {
    try {
      final response = await dioClient.dio
          .post('account/login-by-email/', data: {'email': email});
      print(response);
      final loginSuccessDto = LoginSuccessDto.fromJson(response.data);
      return Success(loginSuccessDto, response.statusCode ?? 200);
    } on DioException catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500; // Default status code
        if (statusCode == 400) {
          return Failure('Invalid request', statusCode);
        } else if (statusCode == 401) {
          return Failure(e.response!.data['id'].toString(), statusCode);
        }
        return Failure('Server error', statusCode);
      } else {
        return Failure('Network error', 0);
      }
    } catch (e) {
      return Failure('Unknown error', 0);
    }
  }

  Future<RegisterSuccessDto> register(RegisterDto registerDto) async {
    try {
      final response = await dioClient.dio.post(
        'account/register/',
        data: registerDto.toJson(),
      );
      print(response);
      final registerSuccessDto = RegisterSuccessDto.fromJson(response.data);

      return registerSuccessDto;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> verifyOtp(VerifyOtpDto verifyOtpDto) async {
    try {
      final response = await dio.post(
        'account/verify-otp/',
        data: verifyOtpDto.toJson(),
      );
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> changePassword(ChangepasswordDto changepasswordDto) async {
    try {
      print(changepasswordDto.toJson());
      final response = await dioClient.dio.post(
        'account/change-password/',
        data: changepasswordDto.toJson(),
      );
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> resetPasswordWithOtp(ResetPasswordDto resetPasswordDto) async {
    try {
      print(resetPasswordDto.toJson());
      final response = await dioClient.dio.post(
        'account/reset-password-with-otp/',
        data: resetPasswordDto.toJson(),
      );
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  // Future<void> loginByGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     // Once signed in, return the UserCredential
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<void> sendForgotPasswordEmail(String email) async {
    try {
      final response = await dioClient.dio.post(
        'account/forgot-password/',
        data: {'email': email},
      );
      print(response);
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> resendOTP(String email) async {
    try {
      final response = await dioClient.dio.post(
        'account/resendOTP/',
        data: {'email': email},
      );
      print(response);
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> updatePersonalInformation(
      UpdatePersonalInformationDto updatePersonalInformationDto) async {
    try {
      final response = await dioClient.dio.post(
        'account/update-personal-information/',
        data: updatePersonalInformationDto.toJson(),
      );
      print(response);
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<String> updateAvatar(
      File image, UploadAvatarDto uploadAvatarDto, String accessToken) async {
    try {
      String imageUrl = '';
      print(accessToken);
      uploadAvatarDto.imageUrl = imageUrl = await uploadImage(image);
      final response = await dioClient.dio.post(
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        'account/update-avatar/',
        data: uploadAvatarDto.toJson(),
      );
      print(response);
      return imageUrl;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<String> uploadImage(File image) async {
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    try {
      final response = await Dio().post(
        'https://api.imgur.com/3/image',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $imgurId',
          },
        ),
        data: {
          'image': base64Image,
          'type': 'base64',
        },
      );

      final data = response.data;
      final imageUrl = data['data']['link'];
      print('Uploaded image URL: $imageUrl');
      return imageUrl.toString();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<TokenRefreshSuccessDto?> refreshToken(String? token) async {
    if (token == null) {
      Get.offAndToNamed(Routes.loginScreen);
    }

    try {
      final response = await dioClient.dio.post(
        'account/refresh-token/',
        data: {'refreshToken': token},
      );
      print(response);
      return TokenRefreshSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          Get.toNamed(Routes.loginScreen);
        }
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }
}

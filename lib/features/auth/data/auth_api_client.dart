import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/features/auth/dtos/reset_password_dto.dart';
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
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
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
}

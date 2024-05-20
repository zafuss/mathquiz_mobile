import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/features/auth/dtos/change_password_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/login_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/login_success_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/register_success_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/upload_avatar_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/verify_otp_dto.dart';

import '../dtos/register_dto.dart';

class AuthApiClient {
  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dio.post(
        'account/login/',
        data: loginDto.toJson(),
      );
      print(response);
      return LoginSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<RegisterSuccessDto> register(RegisterDto registerDto) async {
    try {
      final response = await dio.post(
        'account/register/',
        data: registerDto.toJson(),
      );
      print(response);
      return RegisterSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
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
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> changePassword(ChangepasswordDto changepasswordDto) async {
    try {
      print(changepasswordDto.toJson());
      final response = await dio.post(
        'account/change-password/',
        data: changepasswordDto.toJson(),
      );
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<String> updateAvatar(
      File image, UploadAvatarDto uploadAvatarDto) async {
    try {
      String imageUrl = '';
      uploadAvatarDto.imageUrl = imageUrl = await uploadImage(image);
      final response = await dio.post(
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
    Dio _dio = Dio();
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    try {
      final response = await _dio.post(
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
      // You can do something with the image URL here
      return imageUrl.toString();
      // print('Failed to upload image: ${response.data}');
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}

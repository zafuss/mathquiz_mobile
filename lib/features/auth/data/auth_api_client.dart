import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/features/auth/dtos/login_dto.dart';
import 'package:mathquiz_mobile/features/auth/dtos/login_success_dto.dart';

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

  Future<void> register(RegisterDto registerDto) async {
    try {
      await dio.post(
        'account/register/',
        data: registerDto.toJson(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}

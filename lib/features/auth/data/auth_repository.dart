import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/auth_api_client.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/dtos/register_dto.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../dtos/login_dto.dart';

class AuthRepository {
  final authApiClient = AuthApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<Result<void>> login({
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
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> register(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      await authApiClient.register(
        RegisterDto(email: email, password: password, fullName: fullName),
      );
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> logout() async {
    try {
      await localDataController.deleteClientEmail();
      await localDataController.deleteClientId();
      await localDataController.deleteClientFullName();
      return Success(null);
    } catch (e) {
      return Failure('$e');
    }
  }
}

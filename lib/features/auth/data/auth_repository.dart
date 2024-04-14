import 'package:mathquiz_mobile/features/auth/data/auth_api_client.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/dtos/register_dto.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../dtos/login_dto.dart';

class AuthRepository {
  final authApiClient = AuthApiClient();
  final localDataController = LocalDataController();

  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginSuccessDto = await authApiClient.login(
        LoginDto(email: email, password: password, rememberMe: true),
      );
      await localDataController.saveId(loginSuccessDto.id);
      await localDataController.saveEmail(loginSuccessDto.email);
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> register({
    required String email,
    required String password,
  }) async {
    try {
      await authApiClient.register(
        RegisterDto(email: email, password: password),
      );
    } catch (e) {
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> logout() async {
    try {
      await localDataController.deleteEmail();
      await localDataController.deleteId();
      return Success(null);
    } catch (e) {
      return Failure('$e');
    }
  }
}

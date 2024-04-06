import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/models/level.dart';

class ChooseExamApiClient {
  Future<List<Level>> getLevels() async {
    try {
      // final response = await dio.post(
      //   '/auth/login',
      //   data: loginDto.toJson(),
      // );
      // return LoginSuccessDto.fromJson(response.data);
      return Level.levelList;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

const imgurId = '4dd726d22f92a0a';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://onluyentoan.online/api/',
  ),
);

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://onluyentoan.online/api/',
    ),
  );

  bool _isRefreshing = false;

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.get('clientAccessToken');
          if (accessToken != null && accessToken.toString().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 && !_isRefreshing) {
            _isRefreshing = true;
            final newAccessToken = await _refreshToken();
            if (newAccessToken != null) {
              final requestOptions = e.requestOptions;
              requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              try {
                final cloneReq = await _dio.request(
                  requestOptions.path,
                  options: Options(
                    method: requestOptions.method,
                    headers: requestOptions.headers,
                  ),
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                _isRefreshing = false;
                return handler.resolve(cloneReq);
              } catch (innerError) {
                _isRefreshing = false;
                Get.offAndToNamed(Routes.loginScreen);
                return handler.next(e);
              }
            } else {
              _isRefreshing = false;
              Get.offAndToNamed(Routes.loginScreen);
              return handler.next(e);
            }
          }
          handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<String?> _refreshToken() async {
    LocalDataController localDataController = LocalDataController();
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = await localDataController.getClientRefreshToken();

    if (refreshToken!.isEmpty) {
      Get.offAndToNamed(Routes.loginScreen);
      return null;
    }

    try {
      final response = await _dio
          .post('account/refresh-token/', data: {'refreshToken': refreshToken});
      if (response.statusCode == 200) {
        final data = response.data;
        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];
        prefs.setString("clientAccessToken", newAccessToken);
        prefs.setString("clientRefreshToken", newRefreshToken);
        return newAccessToken;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        Get.offAndToNamed(Routes.loginScreen);
        return null;
      }
    } catch (e) {
      Get.offAndToNamed(Routes.loginScreen);
    }

    return null;
  }
}

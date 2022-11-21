import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pyc/data/model/auth/response/token_response.dart';
import 'package:pyc/screens/login/login_screen.dart';

Future<Dio> getDioClient() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
    ),
  );

  const storage = FlutterSecureStorage();

  //clear Interceptor
  dio.interceptors.clear();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: ((options, handler) async {
        final token = await storage.read(key: 'token');
        if (token == null) {
          // token이 없는 경우 로그인 페이지로 이동
          Get.offAll(LoginScreen.routeName);
          return;
        }
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      }),
      onError: ((error, handler) async {
        if (error.response?.statusCode == HttpStatus.unauthorized) {
          //만약 토큰이 유효하지 않는다면?
          final token = await storage.read(key: 'token');
          final refreshDio = Dio(
            BaseOptions(
              baseUrl:
                  dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
            ),
          );

          refreshDio.interceptors.clear();
          refreshDio.interceptors.add(
            InterceptorsWrapper(
              onError: (e, handler) async {
                // Refresh 또한 실패 할 경우
                if (e.response?.statusCode == HttpStatus.unauthorized) {
                  // token이 없는 경우 storge reset 후 로그인 페이지로 이동
                  await storage.deleteAll();
                  Get.offAll(LoginScreen.routeName);
                  return;
                }
                return handler.next(e);
              },
            ),
          );

          //token을 가지고 Refresh 요청
          refreshDio.options.headers['Authorization'] = 'Bearer $token';
          final res = await refreshDio.get('/api/v1/auth/refresh');
          final accessToken = TokenResponse.fromJSON(res.data).accessToken;

          //token setting
          await storage.write(key: 'token', value: accessToken);

          // AccessToken의 만료로 수행하지 못했던 API 요청에 담겼던 AccessToken 갱신
          error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

          // 수행하지 못했던 API 요청 복사본 생성
          final clonedRequest = await dio.request(error.requestOptions.path,
              options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);

          // API 복사본으로 재요청
          return handler.resolve(clonedRequest);
        }

        return handler.next(error);
      }),
    ),
  );

  return dio;
}

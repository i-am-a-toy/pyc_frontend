import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio getApiClient() {
  return Dio(
    BaseOptions(
      maxRedirects: 1,
      connectTimeout: 2000,
      baseUrl: dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
    ),
  );
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio getApiClient() {
  return Dio(
    BaseOptions(
      baseUrl: dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
    ),
  );
}

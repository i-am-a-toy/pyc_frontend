import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? header;

  ApiRequest({required this.url, this.data, this.header});

  Dio _dio() {
    return Dio(BaseOptions(
      headers: header,
      baseUrl: dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
    ));
  }

  Future<Response> get() async {
    Response response = await _dio().get(url, queryParameters: data);
    return response;
  }

  Future<Response> post() async {
    Response response = await _dio().post(url, data: data);
    return response;
  }
}

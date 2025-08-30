import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:influbee/config/ApiConfig.dart';

import '../Storage/Credentials.dart';

class LoginService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl, // ✅ ensure baseUrl is set
  ));

  Future<Response> login(String email, String password) async {
    print("[AuthService] Starting login...");
    print("[AuthService] Request URL: ${_dio.options.baseUrl}${ApiConfig.login}");
    print("[AuthService] Payload: { email: $email, password: $password }");

    final response = await _dio.post(
      ApiConfig.login,
      data: {
        "email": email,
        "password": password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (_) => true, // ✅ prevent Dio from auto-throwing
      ),
    );

    print("[AuthService] Response Status: ${response.statusCode}");
    print("[AuthService] Response Data: ${response.data}");

    return response;
  }
}

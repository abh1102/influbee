import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:influbee/config/ApiConfig.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://communication-983g.onrender.com/api/v1"));

  Future<Response> login(String email, String password) async {
    try {
      print("[AuthService] Starting login...");
      print("[AuthService] Request URL: ${_dio.options.baseUrl}/login");
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
        ),
      );


      print("[AuthService] Response Status: ${response.statusCode}");
      print("[AuthService] Response Data: ${response.data}");

      return response;
    } catch (e) {
      print("[AuthService] Error occurred during login: $e");
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}

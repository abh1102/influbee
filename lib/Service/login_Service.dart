import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:influbee/config/ApiConfig.dart';

import '../Storage/Credentials.dart';

class LoginService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
  ));

  Future<Response> login(String email, String password) async {
    print("[AuthService] Starting login...");
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
        validateStatus: (_) => true,
      ),
    );

    print("[AuthService] Response Status: ${response.statusCode}");
    print("[AuthService] Response Data: ${response.data}");

    // ✅ Save token & user locally after success
    if (response.statusCode == 200 && response.data != null) {
      await AuthService.to.saveLoginData(response.data);
    }

    return response;
  }
}

import 'package:dio/dio.dart';

import '../config/ApiConfig.dart';

class ForgotPasswordService {
  final Dio _dio = Dio(BaseOptions());

  Future<Response> sendResetLink(String email) async {
    try {
      final response = await _dio.post(
        ApiConfig.ForgetPassword,
        data: {
          "email": email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("[ForgotPasswordService] Status: ${response.statusCode}");
      print("[ForgotPasswordService] Data: ${response.data}");

      return response;
    } catch (e) {
      print("[ForgotPasswordService] Error: $e");
      throw Exception("Failed to send reset link: ${e.toString()}");
    }
  }
}

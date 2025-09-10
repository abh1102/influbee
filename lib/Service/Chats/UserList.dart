import 'package:dio/dio.dart';
import 'package:influbee/config/ApiConfig.dart';

import 'package:dio/dio.dart';
import '../../Storage/Credentials.dart';


class UserList {
  final Dio _dio = Dio(BaseOptions());

  Future<List<dynamic>> getAvailableUsers() async {
    try {
      final token = AuthService.to.accessToken.value; // ✅ fetch token directly
      if (token == null) {
        throw Exception("No token found. Please login first.");
      }

      final response = await _dio.get(
        ApiConfig.UserList,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return response.data["data"]; // return list of users
      } else {
        throw Exception("Failed to fetch users");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }
}

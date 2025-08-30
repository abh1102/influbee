import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:influbee/config/ApiConfig.dart';

import 'dart:io';
import 'package:dio/dio.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<Response> signup({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
    required File profileImage,
  }) async {
    try {
      print("🔹 Preparing signup request...");
      print("Email: $email");
      print("Username: $username");
      print("Password: $password");
      print("ConfirmPassword: $confirmPassword");
      print("PhoneNumber: ${phoneNumber ?? '+919835490475'}");
      print("Role: USER");
      print("DisplayName: $username");
      print("ProfileImage Path: ${profileImage.path}");

      FormData formData = FormData.fromMap({
        "email": email,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "phoneNumber": phoneNumber ?? "+919835490475",
        "role": "USER",
        "displayName": username,
        "profileImage": await MultipartFile.fromFile(
          profileImage.path,
          filename: profileImage.path.split("/").last,
          contentType: MediaType.parse(_getImageContentType(profileImage.path)), // ✅ Added
        ),
      });

      print("✅ FormData prepared successfully");

      final response = await _dio.post(
        ApiConfig.SignUp, // This should point to /api/auth/register
        data: formData,
        options: Options(
          // ✅ Removed Content-Type header - let Dio handle it
        ),
      );

      print("✅ API call completed");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      return response;
    } catch (e) {
      print("❌ Signup API call failed");

      if (e is DioError) {
        print("DioError Type: ${e.type}");
        print("DioError Message: ${e.message}");
        if (e.response != null) {
          print("DioError Response Code: ${e.response?.statusCode}");
          print("DioError Response Data: ${e.response?.data}");
        }
        throw e.response?.data ?? e.message;
      } else {
        print("Unexpected Error: $e");
        throw e.toString();
      }
    }
  }

  // ✅ Helper method to detect image type
  String _getImageContentType(String filePath) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg'; // Default to JPEG
    }
  }
}
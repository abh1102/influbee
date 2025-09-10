import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:influbee/config/ApiConfig.dart';

import '../../Storage/Credentials.dart';

class ChatService {
  final Dio _dio = Dio();
  final token = AuthService.to.accessToken.value; // ✅ fetch token directly

  ChatService() {
    _dio.options.headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
  }

  Future<List<dynamic>> getPersonalMessages(String partnerId) async {
    try {
      final response = await _dio.get(ApiConfig.GetPersonalMessages(partnerId));

      // Print full response for debugging
      debugPrint('GET Personal Messages Response: ${response.data}');

      if (response.statusCode == 200 && response.data['success']) {
        return response.data['data'];
      } else {
        throw Exception('Failed to fetch messages: ${response.data}');
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
      throw Exception('Failed to fetch messages: $e');
    }
  }

  Future<void> sendPersonalMessage({
    required String receiverId,
    required String content,
    String messageType = 'TEXT',
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.SendPersonalMessage,
        data: {
          'receiverId': receiverId,
          'content': content,
          'messageType': messageType,
        },
      );

      // Print full response for debugging
      debugPrint('POST Send Message Response: ${response.data}');

      if (response.statusCode != 200 || !response.data['success']) {
        throw Exception('Failed to send message: ${response.data}');
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
      throw Exception('Failed to send message: $e');
    }
  }
}

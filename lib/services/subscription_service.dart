import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/subscription_response.dart';

class SubscriptionService {
  static const String _baseUrl = "https://granny-backend.vercel.app/subscription-status";
  static const String _appId = "APP_066645";
  static const String _password = "15aa48ae8bb2cbac460f8e983438f343";

  // Register Service
  Future<SubscriptionResponse> registerUser(String subscriberId) async {
    return await _sendRequest(subscriberId, action: "1");
  }

  // Unregister Service
  Future<SubscriptionResponse> unregisterUser(String subscriberId) async {
    return await _sendRequest(subscriberId, action: "0");
  }

  Future<SubscriptionResponse> _sendRequest(String subscriberId, {required String action}) async {
    final Map<String, dynamic> body = {
      "applicationId": _appId,
      "password": _password,
      "version": "1.0",
      "action": action,
      "subscriberId": "tel:$subscriberId",
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return SubscriptionResponse.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to process subscription");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class LoginService {
  static const String _baseUrl = "https://granny-backend.vercel.app/subscription-status";
  static const String _appId = "APP_066645";
  static const String _password = "15aa48ae8bb2cbac460f8e983438f343";

  Future<LoginResponse> checkSubscriptionStatus(String subscriberId) async {
    final Map<String, dynamic> body = {
      "applicationId": _appId,
      "password": _password,
      "subscriberId": "te:$subscriberId",
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to check subscription status");
    }
  }
}

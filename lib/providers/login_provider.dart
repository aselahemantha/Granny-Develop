import 'package:Granny/services/login_service.dart';
import 'package:Granny/models/login_response.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _loginService = LoginService();
  String? phoneNumber;
  String? subscriptionStatus;
  String? statusDetail;
  String? errorMessage;

  Future<void> checkSubscriptionStatus(String subscriberId) async {
    try {
      LoginResponse response = await _loginService.checkSubscriptionStatus(subscriberId);
      phoneNumber = subscriberId;
      subscriptionStatus = response.subscriptionStatus;
      statusDetail = response.statusDetail;

      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}

import 'package:Granny/models/subscription_response.dart';
import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class UnSubscriptionProvider with ChangeNotifier {
  final SubscriptionService _subscriptionService = SubscriptionService();
  String? subscriptionStatus;
  String? statusDetail;
  String? errorMessage;


  Future<void> unsubscribeUser(String subscriberId) async {
    try {
      SubscriptionResponse response = await _subscriptionService.unregisterUser(subscriberId);
      subscriptionStatus = response.subscriptionStatus;
      statusDetail = response.statusDetail;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}

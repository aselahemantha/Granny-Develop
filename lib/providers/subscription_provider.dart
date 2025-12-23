import 'package:Granny/models/subscription_response.dart';
import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class SubscriptionProvider with ChangeNotifier {
  final SubscriptionService _subscriptionService = SubscriptionService();
  String? subscriptionStatus;
  String? statusDetail;
  String? errorMessage;

  Future<void> subscribeUser(String subscriberId) async {
    try {
      SubscriptionResponse response = await _subscriptionService.registerUser(subscriberId);
      subscriptionStatus = response.subscriptionStatus;
      statusDetail = response.statusDetail;

      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

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

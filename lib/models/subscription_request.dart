class SubscriptionRequest {
  final String applicationId;
  final String password;
  final String version;
  final String action;
  final String subscriberId;

  SubscriptionRequest({
    required this.applicationId,
    required this.password,
    required this.version,
    required this.action,
    required this.subscriberId,
  });

  Map<String, dynamic> toJson() {
    return {
      "applicationId": applicationId,
      "password": password,
      "version": version,
      "action": action,
      "subscriberId": subscriberId,
    };
  }
}

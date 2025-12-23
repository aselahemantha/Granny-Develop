class LoginRequest {
  final String applicationId;
  final String password;
  final String subscriberId;

  LoginRequest({
    required this.applicationId,
    required this.password,
    required this.subscriberId,
  });

  Map<String, dynamic> toJson() {
    return {
      "applicationId": applicationId,
      "password": password,
      "subscriberId": subscriberId,
    };
  }
}

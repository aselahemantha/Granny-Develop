class LoginResponse {
  final String version;
  final String subscriptionStatus;
  final String statusCode;
  final String statusDetail;

  LoginResponse({
    required this.version,
    required this.subscriptionStatus,
    required this.statusCode,
    required this.statusDetail,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      version: json["version"],
      subscriptionStatus: json["subscriptionStatus"],
      statusCode: json["statusCode"],
      statusDetail: json["statusDetail"],
    );
  }
}

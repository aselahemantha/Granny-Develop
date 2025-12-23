class SubscriptionResponse {
  final String statusCode;
  final String statusDetail;
  final String subscriptionStatus;

  SubscriptionResponse({
    required this.statusCode,
    required this.statusDetail,
    required this.subscriptionStatus,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      statusCode: json["statusCode"],
      statusDetail: json["statusDetail"],
      subscriptionStatus: json["subscriptionStatus"],
    );
  }
}

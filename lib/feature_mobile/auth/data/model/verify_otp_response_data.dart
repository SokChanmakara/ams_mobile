class VerifyOtpResponseData {
  final String token;

  VerifyOtpResponseData({required this.token});

  factory VerifyOtpResponseData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseData(token: json['resetToken'] as String);
  }

  Map<String, dynamic> toJson() => {'resetToken': token};
}

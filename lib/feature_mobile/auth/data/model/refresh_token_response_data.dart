class RefreshTokenResponseData {
  final String accessToken;
  final String refreshToken;
  final String expiresAt;

  RefreshTokenResponseData({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory RefreshTokenResponseData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: json['expiresAt'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt,
  };
}

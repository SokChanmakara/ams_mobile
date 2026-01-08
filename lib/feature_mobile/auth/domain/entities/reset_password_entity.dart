class ResetPasswordEntity {
  final String token;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordEntity({
    required this.token,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}

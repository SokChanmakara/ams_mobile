class ChangePasswordEntity {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEntity({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {'currentPassword': currentPassword, 'newPassword': newPassword};
  }
}

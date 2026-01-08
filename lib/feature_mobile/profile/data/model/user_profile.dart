import 'package:ams_mobile/core/models/user.dart';

/// User profile response data from /auth/me endpoint
class UserProfile {
  final User user;

  UserProfile({required this.user});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Handle both direct data (GET /auth/me) and nested 'user' key (PUT /auth/me)
    final userData = json.containsKey('user')
        ? json['user'] as Map<String, dynamic>
        : json;
    return UserProfile(user: User.fromJson(userData));
  }

  Map<String, dynamic> toJson() => user.toJson();

  /// Get full name of the user
  String get fullName {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    return '$firstName $lastName'.trim();
  }

  /// Get user's email
  String get email => user.email;

  /// Get user's profile image URL
  String get imageUrl => user.imageUrl ?? '';

  /// Get client/unit information
  String get unitInfo => user.unitNumber ?? '';

  String get phone => user.phone ?? '';
}

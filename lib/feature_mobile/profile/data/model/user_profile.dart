import 'package:ams_mobile/core/models/user.dart';

/// User profile response data from /auth/me endpoint
class UserProfile {
  final User user;

  UserProfile({required this.user});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // The API returns user data directly, not nested in a 'user' field
    return UserProfile(user: User.fromJson(json));
  }

  Map<String, dynamic> toJson() => user.toJson();

  /// Get full name of the user
  String get fullName => '${user.firstName} ${user.lastName}';

  /// Get user's email
  String get email => user.email;

  /// Get user's profile image URL
  String get imageUrl => user.imageUrl;

  /// Get client/unit information
  String get unitInfo => user.clientName;
}

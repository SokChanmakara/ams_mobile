/// Entity for updating user profile
/// Only includes fields that can be updated
class UpdateProfileEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  UpdateProfileEntity({this.firstName, this.lastName, this.email, this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;

    return data;
  }

  /// Check if entity has any updates
  bool get hasUpdates =>
      firstName != null || lastName != null || email != null || phone != null;
}

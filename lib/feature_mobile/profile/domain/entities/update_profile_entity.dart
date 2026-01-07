/// Entity for updating user profile
/// Only includes fields that can be updated
class UpdateProfileEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? imageUrl;

  UpdateProfileEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (imageUrl != null) data['imageUrl'] = imageUrl;

    return data;
  }

  /// Check if entity has any updates
  bool get hasUpdates =>
      firstName != null ||
      lastName != null ||
      email != null ||
      phone != null ||
      imageUrl != null;
}

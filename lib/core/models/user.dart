class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String clientId;
  final String clientName;
  final bool emailVerified;
  final String lastLoginAt;
  final String image;
  final String imageUrl;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.clientId,
    required this.clientName,
    required this.emailVerified,
    required this.lastLoginAt,
    required this.image,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      emailVerified: json['emailVerified'] as bool,
      lastLoginAt: json['lastLoginAt'] as String,
      image: json['image'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'clientId': clientId,
    'clientName': clientName,
    'emailVerified': emailVerified,
    'lastLoginAt': lastLoginAt,
    'image': image,
    'imageUrl': imageUrl,
  };
}

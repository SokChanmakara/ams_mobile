class Condominium {
  final String id;
  final String clientId;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final int totalUnits;
  final int? totalFloor;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Condominium({
    required this.id,
    required this.clientId,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.totalUnits,
    this.totalFloor,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Condominium.fromJson(Map<String, dynamic> json) {
    return Condominium(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      totalUnits: json['totalUnits'] as int,
      totalFloor: json['totalFloor'] as int?,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'totalUnits': totalUnits,
      'totalFloor': totalFloor,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class UnitModel {
  final String id;
  final String condominiumId;
  final String? unitTypeId;
  final String unitNumber;
  final int floor;
  final String areaSqft;
  final int bedrooms;
  final int bathrooms;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Condominium condominium;

  UnitModel({
    required this.id,
    required this.condominiumId,
    this.unitTypeId,
    required this.unitNumber,
    required this.floor,
    required this.areaSqft,
    required this.bedrooms,
    required this.bathrooms,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.condominium,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      condominiumId: json['condominiumId'] as String,
      unitTypeId: json['unitTypeId'] as String?,
      unitNumber: json['unitNumber'] as String,
      floor: json['floor'] as int,
      areaSqft: json['areaSqft'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      condominium: Condominium.fromJson(
        json['condominium'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condominiumId': condominiumId,
      'unitTypeId': unitTypeId,
      'unitNumber': unitNumber,
      'floor': floor,
      'areaSqft': areaSqft,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'condominium': condominium.toJson(),
    };
  }

  String get displayName => '${condominium.name} - Unit $unitNumber';
  String get fullAddress => '${condominium.address}, ${condominium.city}';
}

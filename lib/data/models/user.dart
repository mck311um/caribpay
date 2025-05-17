class UserModel {
  String id;
  String email;
  String? password;
  String firstName;
  String lastName;
  String? phone;
  bool? verified;
  DateTime? dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? nationality;
  String? idType;
  String? idNumber;
  String? idDocumentUrl;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? countryId;
  bool? isDeleted;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.verified,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.nationality,
    this.idType,
    this.idNumber,
    this.idDocumentUrl,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.countryId,
    this.isDeleted,
  });

  static var empty = UserModel(id: '', email: '', firstName: '', lastName: '');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'],
      verified: json['verified'],
      dateOfBirth:
          json['dateOfBirth'] != null
              ? DateTime.tryParse(json['dateOfBirth'])
              : null,
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
      nationality: json['nationality'],
      idType: json['idType'],
      idNumber: json['idNumber'],
      idDocumentUrl: json['idDocumentUrl'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      countryId: json['countryId'],
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'verified': verified,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'nationality': nationality,
    'idType': idType,
    'idNumber': idNumber,
    'idDocumentUrl': idDocumentUrl,
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'city': city,
    'countryId': countryId,
    'isDeleted': isDeleted,
  };

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? phone,
    bool? verified,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nationality,
    String? idType,
    String? idNumber,
    String? idDocumentUrl,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? countryId,
    bool? isDeleted,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      verified: verified ?? this.verified,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nationality: nationality ?? this.nationality,
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      idDocumentUrl: idDocumentUrl ?? this.idDocumentUrl,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      countryId: countryId ?? this.countryId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

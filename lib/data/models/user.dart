class UserModel {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  String phone;
  bool verified;
  DateTime dateOfBirth;
  DateTime createdAt;
  DateTime updatedAt;
  String nationality;
  String idType;
  String idNumber;
  String idDocumentUrl;
  String addressLine1;
  String addressLine2;
  String city;
  String countryId;
  bool isDeleted;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.verified,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
    required this.nationality,
    required this.idType,
    required this.idNumber,
    required this.idDocumentUrl,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.countryId,
    required this.isDeleted,
  });

  static var empty = UserModel(
    id: '',
    email: '',
    password: '',
    firstName: '',
    lastName: '',
    phone: '',
    verified: false,
    dateOfBirth: DateTime(0),
    createdAt: DateTime(0),
    updatedAt: DateTime(0),
    nationality: '',
    idType: '',
    idNumber: '',
    idDocumentUrl: '',
    addressLine1: '',
    addressLine2: '',
    city: '',
    countryId: '',
    isDeleted: false,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      verified: json['verified'] ?? false,
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      nationality: json['nationality'] ?? '',
      idType: json['idType'] ?? '',
      idNumber: json['idNumber'] ?? '',
      idDocumentUrl: json['idDocumentUrl'] ?? '',
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      city: json['city'] ?? '',
      countryId: json['countryId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
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
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
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
}

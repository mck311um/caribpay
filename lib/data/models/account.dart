import 'package:caribpay/data/models/currency.dart';

class Account {
  String id;
  String name;
  String userId;
  String currencyId;
  String countryId;
  double balance;
  String accountNumber;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPrimary;
  bool isDeleted;
  CurrencyModel? currency;

  Account({
    required this.id,
    required this.name,
    required this.userId,
    required this.currencyId,
    required this.countryId,
    required this.balance,
    required this.accountNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.isPrimary,
    required this.isDeleted,
    this.currency,
  });

  Account copyWith({
    String? id,
    String? name,
    String? userId,
    String? currencyId,
    String? countryId,
    double? balance,
    String? accountNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPrimary,
    bool? isDeleted,
    CurrencyModel? currency,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      currencyId: currencyId ?? this.currencyId,
      countryId: countryId ?? this.countryId,
      balance: balance ?? this.balance,
      accountNumber: accountNumber ?? this.accountNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPrimary: isPrimary ?? this.isPrimary,
      isDeleted: isDeleted ?? this.isDeleted,
      currency: currency ?? this.currency,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      currencyId: json['currencyId'] as String,
      countryId: json['countryId'] as String,
      balance: _parseBalance(json['balance']),
      accountNumber: json['accountNumber'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isPrimary: json['isPrimary'] as bool,
      isDeleted: json['isDeleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'currencyId': currencyId,
      'countryId': countryId,
      'balance': balance,
      'accountNumber': accountNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPrimary': isPrimary,
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, name: $name, userId: $userId, currencyId: $currencyId, countryId: $countryId, balance: $balance, accountNumber: $accountNumber, createdAt: $createdAt, updatedAt: $updatedAt, isPrimary: $isPrimary, isDeleted: $isDeleted}';
  }

  static double _parseBalance(dynamic value) {
    try {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.parse(
          value.replaceAll(',', ''),
        ); // Handles "1,000.50" cases
      }
      return 0.0;
    } catch (e) {
      return 0.0; // Fallback if parsing fails
    }
  }
}

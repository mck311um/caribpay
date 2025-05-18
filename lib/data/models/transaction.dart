class Transaction {
  String id;
  String accountId;
  double amount;
  double fee;
  String transactionType;
  String status;
  String direction;
  DateTime createdAt;
  DateTime completedAt;
  String? reference;
  String transferGroupId;
  String userId;

  Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.fee,
    required this.transactionType,
    required this.status,
    required this.direction,
    required this.createdAt,
    required this.completedAt,
    this.reference,
    required this.transferGroupId,
    required this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      amount: _parseBalance(json['amount']),
      fee: _parseBalance(json['fee']),
      transactionType: json['transactionType'] as String,
      status: json['status'] as String,
      direction: json['direction'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: DateTime.parse(json['completedAt'] as String),
      reference: json['reference'] as String?,
      transferGroupId: json['transferGroupId'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'amount': amount,
      'fee': fee,
      'transactionType': transactionType,
      'status': status,
      'direction': direction,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt.toIso8601String(),
      'reference': reference,
      'transferGroupId': transferGroupId,
      'userId': userId,
    };
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

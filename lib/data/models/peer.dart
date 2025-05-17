class Peer {
  String id;
  String name;
  String accountNumber;
  String phone;
  String userId;

  Peer({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.phone,
    required this.userId,
  });

  factory Peer.fromJson(Map<String, dynamic> json) {
    return Peer(
      id: json['id'] as String,
      name: json['name'] as String,
      accountNumber: json['accountNumber'] as String,
      phone: json['phone'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
      'phone': phone,
      'userId': userId,
    };
  }

  Peer copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? phone,
    String? userId,
  }) {
    return Peer(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
    );
  }
}

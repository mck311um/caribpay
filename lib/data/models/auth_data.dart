import 'package:caribpay/data/models/user.dart';

class AuthData {
  UserModel user;
  String token;

  AuthData({required this.user, required this.token});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      user: UserModel.fromJson(json['userData']),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userData': user.toJson(), 'token': token};
  }
}

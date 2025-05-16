import 'package:caribpay/data/models/auth_data.dart';
import 'package:caribpay/services/api.dart';
import 'package:logger/web.dart';

mixin IAuthRepository {
  Future<AuthData?> login(String email, String password);
}

class AuthRepo with IAuthRepository {
  final api = ApiService().client;
  var logger = Logger();

  @override
  Future<AuthData?> login(String email, String password) async {
    try {
      final response = await api.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return AuthData.fromJson(response.data);
    } catch (e) {
      logger.e('Login failed: $e');
      return null;
    }
  }
}

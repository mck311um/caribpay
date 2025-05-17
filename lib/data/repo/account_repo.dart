import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/models/admin_data.dart';
import 'package:caribpay/services/api.dart';
import 'package:logger/web.dart';

mixin IAccountRepository {
  Future<List<Account>> getAccounts();
}

class AccountRepo with IAccountRepository {
  final api = ApiService().client;
  var logger = Logger();

  @override
  Future<List<Account>> getAccounts() async {
    try {
      final response = await api.get('/wallet/');
      final accountsJson = response.data['data'] as List;

      return accountsJson.map((account) => Account.fromJson(account)).toList();
    } catch (e) {
      logger.e('Failed to fetch accounts: $e');
      return [];
    }
  }
}

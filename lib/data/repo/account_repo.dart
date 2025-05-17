import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/services/api.dart';
import 'package:logger/web.dart';

mixin IAccountRepository {
  Future<List<Account>> getAccounts();
  Future<List<Account>> addAccount(String accountName);
}

class AccountRepo with IAccountRepository {
  final api = ApiService().client;
  var logger = Logger();

  @override
  Future<List<Account>> getAccounts() async {
    try {
      final response = await api.get('/account/');
      final accountsJson = response.data['data'] as List;

      return accountsJson.map((account) => Account.fromJson(account)).toList();
    } catch (e) {
      logger.e('Failed to fetch accounts: $e');
      return [];
    }
  }

  @override
  Future<List<Account>> addAccount(String accountName) async {
    try {
      final response = await api.post('/account/', data: {'name': accountName});
      final accountsJson = response.data['data'] as List;

      return accountsJson.map((account) => Account.fromJson(account)).toList();
    } catch (e) {
      logger.e('Failed to add account: $e');
      return [];
    }
  }
}

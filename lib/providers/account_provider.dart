import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/repo/account_repo.dart';
import 'package:flutter/widgets.dart';

class AccountProvider with ChangeNotifier {
  List<Account> _accounts = [];
  Account? _selectedAccount;
  bool _isLoading = false;

  List<Account> get accounts => _accounts;
  Account? get selectedAccount => _selectedAccount;
  bool get isLoading => _isLoading;

  final _repo = AccountRepo();

  Future<void> fetchAccounts() async {
    _isLoading = true;
    notifyListeners();

    _accounts = await _repo.getAccounts();
    if (_accounts.isNotEmpty) {
      _selectedAccount = _accounts[0];
    } else {
      _selectedAccount = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAccount(String accountName) async {
    _isLoading = true;
    notifyListeners();
    _accounts = await _repo.addAccount(accountName);

    _isLoading = false;
    notifyListeners();
  }
}

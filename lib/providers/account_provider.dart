import 'package:caribpay/constants/enums.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/models/peer.dart';
import 'package:caribpay/data/models/transaction.dart';
import 'package:caribpay/data/repo/account_repo.dart';
import 'package:flutter/widgets.dart';

class AccountProvider with ChangeNotifier {
  List<Account> _accounts = [];
  List<Peer> _peers = [];
  List<Transaction> _transactions = [];
  Account? _selectedAccount;
  bool _isLoading = false;

  List<Account> get accounts => _accounts;
  List<Transaction> get transactions => _transactions;
  List<Peer> get peers => _peers;
  Account? get selectedAccount => _selectedAccount;
  bool get isLoading => _isLoading;

  final _repo = AccountRepo();

  Future<void> fetchAccounts() async {
    _isLoading = true;
    notifyListeners();

    _accounts = await _repo.getAccounts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getPeers() async {
    _isLoading = true;
    notifyListeners();

    _peers = await _repo.getPeers();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    _transactions = await _repo.getTransactions();

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

  Future<QueryStatus> addPeer(
    String peerName,
    String phone,
    String accountNumber,
  ) async {
    _isLoading = true;
    notifyListeners();

    final status = await _repo.addPeer(peerName, phone, accountNumber);

    _peers = await _repo.getPeers();

    _isLoading = false;
    notifyListeners();

    return status;
  }

  Future<QueryStatus> internalTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  ) async {
    _isLoading = true;
    notifyListeners();

    final status = await _repo.internalTransfer(
      sendingAccount,
      amount,
      recipient,
      fee,
      reference,
    );

    _accounts = await _repo.getAccounts();

    _isLoading = false;
    notifyListeners();

    return status;
  }

  Future<QueryStatus> peerTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  ) async {
    _isLoading = true;
    notifyListeners();

    final status = await _repo.externalTransfer(
      sendingAccount,
      amount,
      recipient,
      fee,
      reference,
    );

    _accounts = await _repo.getAccounts();

    _isLoading = false;
    notifyListeners();

    return status;
  }
}

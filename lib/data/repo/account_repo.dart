import 'package:caribpay/constants/enums.dart';
import 'package:caribpay/constants/utils.dart';
import 'package:caribpay/data/models/account.dart';
import 'package:caribpay/data/models/peer.dart';
import 'package:caribpay/data/models/transaction.dart';
import 'package:caribpay/services/api.dart';
import 'package:logger/web.dart';

mixin IAccountRepository {
  Future<List<Account>> getAccounts();
  Future<List<Peer>> getPeers();
  Future<List<Account>> addAccount(String accountName);
  Future<List<Transaction>> getTransactions();
  Future<List<Transaction>> getTransactionsByAccountNumber(
    String accountNumber,
  );

  Future<QueryStatus> addPeer(
    String peerName,
    String phone,
    String accountNumber,
  );
  Future<QueryStatus> internalTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  );
  Future<QueryStatus> externalTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  );
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
  Future<List<Peer>> getPeers() async {
    try {
      final response = await api.get('account/peers');
      final peersJson = response.data['data'] as List;
      logger.i('Peers: $peersJson');
      return peersJson.map((peer) => Peer.fromJson(peer)).toList();
    } catch (e) {
      logger.e('Failed to fetch peers: $e');
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

  @override
  Future<QueryStatus> addPeer(
    String peerName,
    String phone,
    String accountNumber,
  ) async {
    try {
      final data = {
        'name': peerName,
        'phone': phone,
        'accountNumber': accountNumber,
      };
      await api.post('account/peer', data: data);
      return QueryStatus.success;
    } catch (e) {
      handleTransactionError(e, title: 'Add Peer Failed');
      return QueryStatus.error;
    }
  }

  @override
  Future<QueryStatus> internalTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  ) async {
    try {
      final data = {
        'accountNumber': sendingAccount,
        'amount': amount,
        'recipient': recipient,
        'fee': fee,
        'reference': reference,
      };
      await api.post('transaction/transfer/internal', data: data);
      return QueryStatus.success;
    } catch (e) {
      handleTransactionError(e, title: 'Internal Transfer Failed');
      return QueryStatus.error;
    }
  }

  @override
  Future<QueryStatus> externalTransfer(
    String sendingAccount,
    double amount,
    String recipient,
    double fee,
    String reference,
  ) async {
    try {
      final data = {
        'accountNumber': sendingAccount,
        'amount': amount,
        'recipient': recipient,
        'fee': fee,
        'reference': reference,
      };
      await api.post('transaction/transfer', data: data);
      return QueryStatus.success;
    } catch (e) {
      handleTransactionError(e, title: 'Internal Transfer Failed');
      return QueryStatus.error;
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final response = await api.get('/transaction/history');
      final transactionsJson = response.data['data'] as List;
      logger.i('Transactions: $transactionsJson');
      return transactionsJson
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } catch (e) {
      logger.e('Failed to fetch transactions: $e');
      return [];
    }
  }

  @override
  Future<List<Transaction>> getTransactionsByAccountNumber(
    String accountNumber,
  ) async {
    try {
      final response = await api.get('transaction/history/$accountNumber');
      final transactionsJson = response.data['data'] as List;
      logger.i('Transactions: $transactionsJson');
      return transactionsJson
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } catch (e) {
      logger.e('Failed to fetch transactions: $e');
      return [];
    }
  }
}

import 'package:caribpay/constants/utils.dart';
import 'package:caribpay/data/models/admin_data.dart';
import 'package:caribpay/data/repo/admin_repo.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  AdminData _adminData = AdminData.empty;
  AdminData get adminData => _adminData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final repo = AdminRepo();

  Future<void> fetchAdminData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _adminData = await repo.getAdminData();
    } catch (e) {
      logger.e('Error fetching admin data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

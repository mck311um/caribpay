import 'package:caribpay/data/models/admin_data.dart';
import 'package:caribpay/services/api.dart';
import 'package:logger/web.dart';

mixin IAdminRepository {
  Future<AdminData> getAdminData();
}

class AdminRepo with IAdminRepository {
  final api = ApiService().client;
  var logger = Logger();

  @override
  Future<AdminData> getAdminData() async {
    try {
      final response = await api.get('/admin');
      return AdminData.fromJson(response.data);
    } catch (e) {
      logger.e('Failed to fetch admin data: $e');
      return AdminData();
    }
  }
}

import 'package:caribpay/data/models/country.dart';
import 'package:caribpay/data/models/currency.dart';

class AdminData {
  List<CountryModel>? countries;
  List<CurrencyModel>? currencies;

  AdminData({this.countries, this.currencies});

  static var empty = AdminData(countries: [], currencies: []);

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      countries:
          json['countries'] != null
              ? (json['countries'] as List)
                  .map((e) => CountryModel.fromJson(e))
                  .toList()
              : null,
      currencies:
          json['currencies'] != null
              ? (json['currencies'] as List)
                  .map((e) => CurrencyModel.fromJson(e))
                  .toList()
              : null,
    );
  }
}

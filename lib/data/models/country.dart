class CountryModel {
  String id;
  String name;
  String code;
  String currencyId;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.currencyId,
  });

  static var empty = CountryModel(id: '', name: '', code: '', currencyId: '');

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      currencyId: json['currencyId'] as String,
    );
  }
}

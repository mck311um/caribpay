class CurrencyModel {
  String id;
  String name;
  String code;
  String symbol;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
    );
  }
}

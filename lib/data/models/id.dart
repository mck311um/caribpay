class IDType {
  final String label;
  final String value;

  IDType({required this.label, required this.value});

  factory IDType.fromMap(Map<String, dynamic> map) {
    return IDType(label: map['label'] ?? '', value: map['value'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'value': value};
  }
}

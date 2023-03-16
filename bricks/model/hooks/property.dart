import 'dart:convert';

/// {@template property}
/// A property for model class
/// {@endtemplate}
class Property {
  /// {@macro property}
  const Property({
    required this.name,
    required this.type,
    this.isNullable = false,
  });

  /// The name of the property
  final String name;

  /// The type of the property
  final String type;

  /// A flag if the property is nullable
  final bool isNullable;

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      name: map['name'] as String,
      type: map['type'] as String,
      isNullable: (map['type'] as String).endsWith('?'),
    );
  }

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source) as Map<String, dynamic>);
}

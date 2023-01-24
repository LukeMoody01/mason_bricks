import 'package:equatable/equatable.dart';

/// {@template model}
/// Model description
/// {@endtemplate}
class Model extends Equatable {
  /// {@macro model}
  const Model({ 
    required this.model,
    required this.name,
    this.age,
  });

    /// Creates a Model from Json map
  factory Model.fromJson(Map<String, dynamic> json) => Model(
        model: json['model'] as String,
        name: json['name'] as String,
        age: json['age'] as String?,
      );

  /// A description for model
  final String model;

  /// A description for name
  final String name;

  /// A description for age
  final String? age;

    /// Creates a copy of the current Model with property changes
  Model copyWith({ 
    String? model,
    String? name,
    String? Function()? age,
  }) {
    return Model(
      model: model ?? this.model,
      name: name ?? this.name,
      age: age!=null ? age() : this.age,
    );
  }


    @override
  List<Object?> get props => [
        model,
        name,
        age,
      ];

    /// Creates a Json map from a Model
  Map<String, dynamic> toJson(Model instance) => <String, dynamic>{ 
        'model': instance.model,
        'name': instance.name,
        'age': instance.age,
      };
}

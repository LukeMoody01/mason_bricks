

part 'admin.g.dart';

class Admin {
  const Admin({ 
  required this.id,
  required this.name,
  required this.lastLoggedIn,
  });

  final String id;
  final String name;
  final DateTime lastLoggedIn;

  Admin copyWith({ 
    String? id,
    String? name,
    DateTime? lastLoggedIn,
  }) {
    return Admin(
      id: id ?? this.id,
      name: name ?? this.name,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
    );
  }
  
  factory Admin.fromJson(Map<String, dynamic> data) => _$AdminFromJson(data);
  Map<String, dynamic> toJson() => _$AdminToJson(this);
}

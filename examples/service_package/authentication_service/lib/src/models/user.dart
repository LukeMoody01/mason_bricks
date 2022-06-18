

class User {
  const User({ 
  required this.id,
  required this.name,
  required this.age,
  required this.lastSeen,
  });

  final String id;
  final String name;
  final int age;
  final DateTime lastSeen;

  User copyWith({ 
    String? id,
    String? name,
    int? age,
    DateTime? lastSeen,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
  
}

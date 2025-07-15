import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  bool isSynced;


  User({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isSynced = false
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isSynced: json['isSynced'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isSynced': isSynced,
    };
  }
}

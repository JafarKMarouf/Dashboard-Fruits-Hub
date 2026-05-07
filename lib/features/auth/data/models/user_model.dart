import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      uId: jsonData['uid'],
      name: jsonData['name'],
      email: jsonData['email'],
      role: jsonData['role'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uId: userEntity.uId,
      name: userEntity.name,
      email: userEntity.email,
      role: userEntity.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uid': uId, 'role': role};
  }
}

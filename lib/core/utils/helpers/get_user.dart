import 'dart:convert';

import '../../../features/auth/data/models/user_model.dart';
import '../../../features/auth/domain/entities/user_entity.dart';
import '../../services/local/shared_prefs_service.dart';
import '../constants.dart';

UserEntity getUser() {
  final jsonData = SharedPrefsService.getString(kUserData);
  return UserModel.fromJson(jsonDecode(jsonData!));
}

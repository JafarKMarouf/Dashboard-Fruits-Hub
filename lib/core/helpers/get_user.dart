import 'dart:convert';

import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../services/shared_preferences_service.dart';
import '../utils/constants.dart';

UserEntity getUser() {
  var jsonData = SharedPreferencesService.getString(kUserData);
  return UserModel.fromJson(jsonDecode(jsonData!));
}

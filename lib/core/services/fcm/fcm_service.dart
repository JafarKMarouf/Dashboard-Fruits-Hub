import 'package:dartz/dartz.dart';
import '../../errors/failure.dart';

abstract class FcmService {
  Future<Either<Failure, void>> sendToTopic({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  });

  Future<Either<Failure, void>> sendToDevice({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  });
}

import 'package:logic/domain/entities/dhikr/dhikr_entity.dart';

abstract class IDhikrRepository {
  Future<DhikrEntity> getDhikr({required int dhikrId});
  Future<List<DhikrEntity>> getDhikrs();
  Future<bool> subscribeToDhikr({
    required int dhikrId,
    DateTime? reminderAt,
    required String userToken,
  });
  Future<bool> unSubscribeToDhikr({
    required int dhikrId,
    required String userToken,
  });
}

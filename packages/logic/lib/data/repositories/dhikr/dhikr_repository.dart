import 'package:logic/domain/entities/dhikr/dhikr_entity.dart';
import 'package:logic/domain/repositories/dhikr/dhikr_repository.dart';

class DhikrRepository implements IDhikrRepository {
  @override
  Future<DhikrEntity> getDhikr({required int dhikrId}) {
    // TODO: implement getDhikr
    throw UnimplementedError();
  }

  @override
  Future<List<DhikrEntity>> getDhikrs() {
    // TODO: implement getDhikrs
    throw UnimplementedError();
  }

  @override
  Future<bool> subscribeToDhikr({
    required int dhikrId,
    DateTime? reminderAt,
    required String userToken,
  }) {
    // TODO: implement subscribeToDhikr
    throw UnimplementedError();
  }

  @override
  Future<bool> unSubscribeToDhikr({
    required int dhikrId,
    required String userToken,
  }) {
    // TODO: implement unSubscribeToDhikr
    throw UnimplementedError();
  }
}

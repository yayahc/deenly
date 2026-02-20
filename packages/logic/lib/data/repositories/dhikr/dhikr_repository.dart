import 'package:logic/domain/entities/dhikr/dhikr_entity.dart';
import 'package:logic/domain/repositories/dhikr/dhikr_repository.dart';
import 'package:logic/extensions/dto_extensions.dart';

import '../../remote_datasources/dhikr/dhikr_remote_datasource.dart';

class DhikrRepository implements IDhikrRepository {
  final IDhikrRemoteDatasource _iDhikrRemoteDatasource;

  DhikrRepository(this._iDhikrRemoteDatasource);

  @override
  Future<DhikrEntity> getDhikr({required int dhikrId}) async {
    return (await _iDhikrRemoteDatasource.getDhikr(dhikrId: dhikrId)).toEntity;
  }

  @override
  Future<List<DhikrEntity>> getDhikrs() async {
    return (await _iDhikrRemoteDatasource.getDhikrs())
        .map((d) => d.toEntity)
        .toList();
  }

  @override
  Future<bool> subscribeToDhikr({
    required int dhikrId,
    DateTime? reminderAt,
    required String userToken,
  }) async {
    return (await _iDhikrRemoteDatasource.subscribeToDhikr(
      dhikrId: dhikrId,
      userToken: userToken,
      reminderAt: reminderAt,
    ));
  }

  @override
  Future<bool> unSubscribeToDhikr({
    required int dhikrId,
    required String userToken,
  }) async {
    return (await _iDhikrRemoteDatasource.unSubscribeToDhikr(
      dhikrId: dhikrId,
      userToken: userToken,
    ));
  }
}

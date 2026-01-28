import 'package:logic/data/models/dhikr/dhikr_model.dart';

abstract class IDhikrRemoteDatasource {
  Future<DhikrModel> getDhikr({required int dhikrId});
  Future<List<DhikrModel>> getDhikrs();
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

class DhikrRemoteDatasource implements IDhikrRemoteDatasource {
  @override
  Future<DhikrModel> getDhikr({required int dhikrId}) {
    // TODO: implement getDhikr
    throw UnimplementedError();
  }

  @override
  Future<List<DhikrModel>> getDhikrs() {
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

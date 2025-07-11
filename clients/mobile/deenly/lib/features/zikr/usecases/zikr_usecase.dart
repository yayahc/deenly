import 'package:injectable/injectable.dart';
import '../data/repositories/zikr_datasource_repository.dart';
import '../domain/models/zikr_model.dart';

@singleton
class ZikrUsecase {
  final ZikrDatasourceRepository _zikrDatasourceRepository;

  ZikrUsecase(this._zikrDatasourceRepository);

  Future<List<ZikrModel>> getZirks() async {
    return _zikrDatasourceRepository.getZikrs();
  }

  Future<ZikrModel?> getZirk(int id) async {
    return _zikrDatasourceRepository.getZikr(id);
  }

  Future<int?> createZirk(ZikrModel zikr) async {
    return _zikrDatasourceRepository.createZirk(zikr);
  }
}

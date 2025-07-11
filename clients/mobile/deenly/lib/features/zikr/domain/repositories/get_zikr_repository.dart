import '../models/zikr_model.dart';

abstract class GetZikrRepository {
  Future<List<ZikrModel>> getZikrs();
  Future<ZikrModel?> getZikr(int id);
}

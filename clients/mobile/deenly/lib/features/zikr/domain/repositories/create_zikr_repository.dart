import '../models/zikr_model.dart';

abstract class CreateZikrRepository {
  Future<int?> createZirk(ZikrModel zikr);
}

import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_error/app_error.dart';
import '../../../../../core/dev_tools/debug_logger.dart';
import '../../../domain/models/zikr_model.dart';
import '../../../services/local_storage/local_storage.dart';
import '../../repositories/zikr_datasource_repository.dart';

@Singleton(as: ZikrDatasourceRepository)
class ZikrLocalDatasource implements ZikrDatasourceRepository {
  @override
  Future<ZikrModel?> getZikr(int id) async {
    try {
      final zikrJ = LocalStorage.instance.getString(id.toString());
      return zikrJ != null ? ZikrModel.fromJson(json.decode(zikrJ)) : null;
    } catch (e) {
      DebugLogger.instance
          .log(e.toString(), logedAt: 'ZikrLocalDatasource/getZikr');
      return null;
    }
  }

  @override
  Future<List<ZikrModel>> getZikrs() async {
    final List<ZikrModel> zikrs = [];
    final zirksIds =
        LocalStorage.instance.getStringList('zirksIds') as List<String>;
    for (final id in zirksIds) {
      [...zikrs, await getZikr(int.parse(id))];
    }
    return zikrs;
  }

  @override
  Future<int?> createZirk(ZikrModel zikr) async {
    try {
      if (zikr.id != null) {
        LocalStorage.instance
            .setString(zikr.id.toString(), json.encode(zikr.toJson()));
        return zikr.id;
      }
      throw GenericAppError(errorMessage: "Zikr id can't be null");
    } catch (e) {
      DebugLogger.instance
          .log(e.toString(), logedAt: 'ZikrLocalDatasource/createZikr');
      return null;
    }
  }
}

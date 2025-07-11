import '../../domain/repositories/create_zikr_repository.dart';
import '../../domain/repositories/get_zikr_repository.dart';

abstract class ZikrDatasourceRepository
    implements GetZikrRepository, CreateZikrRepository {}

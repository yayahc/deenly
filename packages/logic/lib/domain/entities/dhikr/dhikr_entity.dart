import 'package:logic/domain/entities/user/user_entities.dart';

class DhikrEntity {
  final int id;
  final List<String> invocation;
  final List<UserEntity> subscribers;
  final String benefice;
  final DateTime? remindAt;

  DhikrEntity({
    required this.id,
    required this.invocation,
    required this.subscribers,
    required this.benefice,
    this.remindAt,
  });
}

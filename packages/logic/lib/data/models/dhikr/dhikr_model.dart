import '../../../domain/entities/entities.dart';

class DhikrModel {
  final int id;
  final List<String> invocation;
  final List<UserEntity> subscribers;
  final String benefice;
  final DateTime? remindAt;
  final DateTime? createdAt;

  DhikrModel({
    required this.id,
    required this.invocation,
    required this.subscribers,
    required this.benefice,
    this.remindAt,
    this.createdAt,
  });
}

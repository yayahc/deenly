import 'package:json_annotation/json_annotation.dart';

part 'zikr_model.g.dart';

@JsonSerializable()
class ZikrModel {
  final int? id;
  final String name;
  final String? description;
  final DateTime? remindAt;
  final DateTime createdAt;

  ZikrModel(
      {this.id,
      required this.name,
      this.description,
      this.remindAt,
      required this.createdAt});

  factory ZikrModel.fromJson(Map<String, dynamic> json) =>
      _$ZikrModelFromJson(json);
  Map<String, dynamic> toJson() => _$ZikrModelToJson(this);
}

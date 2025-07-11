// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zikr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZikrModel _$ZikrModelFromJson(Map<String, dynamic> json) => ZikrModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      remindAt: json['remindAt'] == null
          ? null
          : DateTime.parse(json['remindAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ZikrModelToJson(ZikrModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'remindAt': instance.remindAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

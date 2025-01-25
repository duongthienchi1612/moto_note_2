// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessoryTypeEntity _$AccessoryTypeEntityFromJson(Map<String, dynamic> json) =>
    AccessoryTypeEntity(
      id: (json['id'] as num?)?.toInt(),
      nameVi: json['name_vi'] as String?,
      nameEn: json['name_en'] as String?,
    );

Map<String, dynamic> _$AccessoryTypeEntityToJson(
        AccessoryTypeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_vi': instance.nameVi,
      'name_en': instance.nameEn,
    };

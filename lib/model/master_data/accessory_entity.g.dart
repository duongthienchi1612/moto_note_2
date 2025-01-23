// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessoryEntity _$AccessoryEntityFromJson(Map<String, dynamic> json) =>
    AccessoryEntity(
      id: (json['id'] as num?)?.toInt(),
      nameVi: json['name_vi'] as String?,
      nameEn: json['name_en'] as String?,
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$AccessoryEntityToJson(AccessoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_vi': instance.nameVi,
      'name_en': instance.nameEn,
      'image_path': instance.imagePath,
    };

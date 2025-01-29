// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) => DeviceEntity()
  ..id = json['id'] as String?
  ..deviceName = json['device_name'] as String?
  ..deviceTypeId = (json['device_type_id'] as num?)?.toInt()
  ..deviceTypeName = json['device_type_name'] as String?
  ..lastReplacementKm = (json['last_replacement_km'] as num?)?.toInt()
  ..nextReplacementKm = (json['next_replacement_km'] as num?)?.toInt()
  ..lastReplacementDate = json['last_replacement_date'] == null
      ? null
      : DateTime.parse(json['last_replacement_date'] as String)
  ..note = json['note'] as String?
  ..createAt = json['create_at'] == null
      ? null
      : DateTime.parse(json['create_at'] as String);

Map<String, dynamic> _$DeviceEntityToJson(DeviceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.deviceName,
      'device_type_id': instance.deviceTypeId,
      'device_type_name': instance.deviceTypeName,
      'last_replacement_km': instance.lastReplacementKm,
      'next_replacement_km': instance.nextReplacementKm,
      'last_replacement_date': instance.lastReplacementDate?.toIso8601String(),
      'note': instance.note,
      'create_at': instance.createAt?.toIso8601String(),
    };

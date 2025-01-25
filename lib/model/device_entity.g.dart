// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) => DeviceEntity()
  ..id = json['id'] as String?
  ..deviceName = json['deviceName'] as String?
  ..deviceTypeId = (json['deviceTypeId'] as num?)?.toInt()
  ..deviceTypeName = json['deviceTypeName'] as String?
  ..lastReplacementKm = (json['lastReplacementKm'] as num?)?.toInt()
  ..nextReplacementKm = (json['nextReplacementKm'] as num?)?.toInt()
  ..lastReplacementDate = json['lastReplacementDate'] == null
      ? null
      : DateTime.parse(json['lastReplacementDate'] as String)
  ..note = json['note'] as String?
  ..createAt = json['createAt'] == null
      ? null
      : DateTime.parse(json['createAt'] as String);

Map<String, dynamic> _$DeviceEntityToJson(DeviceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceName': instance.deviceName,
      'deviceTypeId': instance.deviceTypeId,
      'deviceTypeName': instance.deviceTypeName,
      'lastReplacementKm': instance.lastReplacementKm,
      'nextReplacementKm': instance.nextReplacementKm,
      'lastReplacementDate': instance.lastReplacementDate?.toIso8601String(),
      'note': instance.note,
      'createAt': instance.createAt?.toIso8601String(),
    };

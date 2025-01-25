import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';
import 'base/base_entity.dart';
part 'device_entity.g.dart';

@JsonSerializable()
class DeviceEntity extends CoreEntity {
  @override
  String get table => Database.devices;

  String? deviceName;
  int? deviceTypeId;
  String? deviceTypeName;
  int? lastReplacementKm;
  int? nextReplacementKm;
  DateTime? lastReplacementDate;
  String? note;
  DateTime? createAt;

  DeviceEntity();

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    final entity = DeviceEntity.fromJson(json);
    return entity as T;
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) => _$DeviceEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceEntityToJson(this);
}

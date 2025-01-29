import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';
import 'base/base_entity.dart';
part 'device_entity.g.dart';

@JsonSerializable()
class DeviceEntity extends CoreEntity {
  @override
  String get table => Database.devices;

  @JsonKey(name: 'device_name')
  String? deviceName;
  
  @JsonKey(name: 'device_type_id')
  int? deviceTypeId;

  @JsonKey(name: 'device_type_name')
  String? deviceTypeName;

  @JsonKey(name: 'last_replacement_km')
  int? lastReplacementKm;

  @JsonKey(name: 'next_replacement_km')
  int? nextReplacementKm;

  @JsonKey(name: 'last_replacement_date')
  DateTime? lastReplacementDate;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'create_at')
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

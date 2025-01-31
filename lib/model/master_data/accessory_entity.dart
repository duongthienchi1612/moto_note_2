import 'package:json_annotation/json_annotation.dart';
import '../../../constants.dart';
import '../base/base_entity.dart';

part 'accessory_entity.g.dart';

@JsonSerializable()
class AccessoryEntity extends CoreReadEntity {
  @override
  String get table => DatabaseTable.accessories;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name_vi')
  final String? nameVi;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'image_path')
  final String? imagePath;

  @JsonKey(name: 'type')
  final int? type;

  AccessoryEntity({
    this.id,
    this.nameVi,
    this.nameEn,
    this.imagePath,
    this.type
  });

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    final entity = AccessoryEntity.fromJson(json);
    return entity as T;
  }

  factory AccessoryEntity.fromJson(Map<String, dynamic> json) {
    return _$AccessoryEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AccessoryEntityToJson(this);
}

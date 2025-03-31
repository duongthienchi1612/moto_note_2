import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../constants.dart';
import '../../utilities/localization_helper.dart';
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

// Extension cho AccessoryEntity
extension AccessoryEntityExtension on AccessoryEntity {
  String getLocalizedName(BuildContext context) {
    final String languageCode = LocalizationHelper.getCurrentLanguageCode(context);
    if (languageCode == 'vi') {
      return nameVi ?? '';
    } else {
      return nameEn ?? nameVi ?? '';  // Fallback to nameVi if nameEn is null
    }
  }
}
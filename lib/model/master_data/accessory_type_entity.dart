import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../constants.dart';
import '../../utilities/localization_helper.dart';
import '../base/base_entity.dart';

part 'accessory_type_entity.g.dart';

@JsonSerializable()
class AccessoryTypeEntity extends CoreReadEntity {
  @override
  String get table => DatabaseTable.accessoriesType;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name_vi')
  final String? nameVi;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  AccessoryTypeEntity({
    this.id,
    this.nameVi,
    this.nameEn,
  });

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    final entity = AccessoryTypeEntity.fromJson(json);
    return entity as T;
  }

  factory AccessoryTypeEntity.fromJson(Map<String, dynamic> json) {
    return _$AccessoryTypeEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AccessoryTypeEntityToJson(this);
}

// Extension cho AccessoryTypeEntity
extension AccessoryTypeEntityExtension on AccessoryTypeEntity {
  String getLocalizedName(BuildContext context) {
    String languageCode = LocalizationHelper.getCurrentLanguageCode(context);
    if (languageCode == 'vi') {
      return nameVi ?? '';
    } else {
      return nameEn ?? nameVi ?? '';  // Fallback to nameVi if nameEn is null
    }
  }
}



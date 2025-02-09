// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity()
  ..id = json['id'] as String?
  ..create_date = json['create_date'] == null
      ? null
      : DateTime.parse(json['create_date'] as String)
  ..userName = json['user_name'] as String?
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_date': instance.create_date?.toIso8601String(),
      'user_name': instance.userName,
      'avatar': instance.avatar,
    };

import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';
import 'base/base_entity.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends CoreEntity {
  @override
  String get table => DatabaseTable.users;

  @JsonKey(name: 'user_name')
  String? userName;
  
  @JsonKey(name: 'avatar')
  String? avatar;

  UserEntity();

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    final entity = UserEntity.fromJson(json);
    return entity as T;
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

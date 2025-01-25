abstract class CoreReadEntity {
  String get table;
  Map<String, dynamic> toJson();

  external T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json);
}

abstract class CoreEntity extends CoreReadEntity {
  String? id;
}

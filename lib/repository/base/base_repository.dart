import 'package:basic_utils/basic_utils.dart';

import '../../dependencies.dart';
import '../../model/base/base_entity.dart';
import '../../utilities/database_factory.dart';
import 'interface.dart';

abstract class BaseReadRepository<T extends CoreReadEntity> implements IBaseReadRepository<T> {
  final dbFactory = injector.get<DatabaseFactory>();

  BaseReadRepository();

  @override
  Future<T?> getById(String? id) async {
    if (StringUtils.isNullOrEmpty(id)) {
      return null;
    }
    final condition = "Id = '$id'";
    final items = await list(condition, null, null, null, null);
    return items.isEmpty ? null : items[0];
  }

  @override
  Future<List<T>?> listAll() async {
    return list(null, null, null, null, null, []);
  }

  @override
  Future<List<T>> list(String? where, String? orderBy, bool? asc, int? pageIndex, int? pageSize,
      [final List<String> args = const <String>[]]) async {
    return listSelected(null, where, orderBy, asc, pageIndex, pageSize, args);
  }

  Future<List<T>> listSelected(String? columns, String? where, String? orderBy, bool? asc, int? pageIndex, int? pageSize,
      [final List<String> args = const <String>[]]) async {
    final item = injector.get<T>();
    final selected = StringUtils.isNullOrEmpty(columns) ? '*' : columns;
    var query = 'select $selected from ${item.table} ';

    if (where != null) {
      query += 'where $where ';
    }

    if (orderBy != null) {
      final direction = asc == true ? 'ASC' : 'DESC';
      query += 'order by $orderBy $direction ';
    }

    if (pageIndex != null && pageSize != null) {
      final skip = (pageIndex - 1) * pageSize;
      final limit = pageSize;
      query += 'LIMIT $limit OFFSET $skip ';
    }
    return listRaw(query, item.fromJsonConvert, args);
  }

  @override
  Future<List<T>> listRaw<T>(
      String query,
      T Function(
        Map<String, dynamic>,
      ) mapper,
      [final List<String> args = const <String>[]]) async {
    final database = await dbFactory.getMasterData();
    final list = await database.list(query, args);
    return list.map((f) => mapper(f)).toList();
  }
}

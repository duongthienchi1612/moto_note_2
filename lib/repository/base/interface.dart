import '../../model/base/base_entity.dart';

class IBaseReadRepository<T extends CoreReadEntity> {
  Future<T?> getById(String id) async {
    return null;
  }

  Future<List<T>?> listAll() async {
    return null;
  }

  Future<List<TEntity>?> listRaw<TEntity>(String query, TEntity Function(Map<String, dynamic>) mapper,
      [final List<String> args = const <String>[]]) async {
    return null;
  }

  Future<List<T>?> list(String where, String orderBy, bool asc, int pageIndex, int pageSize,
      [final List<String> args = const <String>[]]) async {
    return null;
  }
}

import '../../constants.dart';
import '../../model/user_entity.dart';
import '../base/base_repository.dart';
import '../interface/users_repository.dart';

class UsersRepository extends BaseRepository<UserEntity> implements IUserRepository {
  UsersRepository() : super(DatabaseName.moteNote);
}

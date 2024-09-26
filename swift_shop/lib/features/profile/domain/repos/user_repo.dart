
import 'package:swift_shop/features/profile/domain/models/user_model.dart';

import '../../../../core/utils/typedefs.dart';

abstract class UserRepo {
  ResultFuture<UserModel> getUser(String userId);
  ResultFuture<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  });
}

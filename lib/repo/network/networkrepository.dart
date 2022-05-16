import 'package:kuhoodemo/model/singleusermodel.dart';
import 'package:kuhoodemo/model/usermodel.dart';

abstract class NetworkRepository {
  Future<UserModel> getUserList({int index = 0});

  Future<SingleUserModel> getSingleUser({int id = 2});
}

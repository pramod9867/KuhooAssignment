import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuhoodemo/model/singleusermodel.dart';
import 'package:kuhoodemo/model/usermodel.dart';
import 'package:kuhoodemo/network/dioclient.dart';
import 'package:kuhoodemo/repo/network/networkrepository.dart';
import 'package:kuhoodemo/utils/constants/appconstants.dart';

class NetworkRepositoryImpl extends NetworkRepository {
  @override
  Future<UserModel> getUserList({int index = 0}) async {
    ApiClient apiClient = ApiClient.defaultClient();
    final response = await apiClient.dioClient!
        .get(AppConstants.network.getUserList(), queryParameters: {
      'page': index,
    });

    UserModel userModel = UserModel.fromJson(response?.data);
    return userModel;
  }

  @override
  Future<SingleUserModel> getSingleUser({int id = 0}) async {
    ApiClient apiClient = ApiClient.defaultClient();
    final response = await apiClient.dioClient!.get(
        AppConstants.network.getSingleUser(id: id),
        queryParameters: {});

    SingleUserModel singleUserModel = SingleUserModel.fromJson(response?.data);
    return singleUserModel;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:kuhoodemo/model/usermodel.dart';
import 'package:kuhoodemo/network/networkstatus.dart';
import 'package:kuhoodemo/repo/network/networkrepository.dart';
import 'package:kuhoodemo/repo/network/networkrepositoryimpl.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel = UserModel();
  List<Data> data = [];
  NetworkStatus networkStatus = NetworkStatus.init;
  NetworkRepository networkRepository = NetworkRepositoryImpl();

  getUserList(context, {int index = 0}) async {
    try {
      print(index);
      if (index != 0) {
        print("Into the load More");
        networkStatus = NetworkStatus.loadMore;
        notifyListeners();
      } else {
        networkStatus = NetworkStatus.loading;
        // notifyListeners();
      }
      userModel = await networkRepository.getUserList(index: index);
      data.addAll(userModel.data ?? []);

      networkStatus = NetworkStatus.successful;
      notifyListeners();
    } catch (err) {
      print(err);
      networkStatus = NetworkStatus.error;
      notifyListeners();
    }
  }
}

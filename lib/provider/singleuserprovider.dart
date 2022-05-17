import 'package:flutter/cupertino.dart';
import 'package:kuhoodemo/model/singleusermodel.dart';
import 'package:kuhoodemo/model/usermodel.dart';
import 'package:kuhoodemo/network/networkstatus.dart';
import 'package:kuhoodemo/repo/network/networkrepository.dart';
import 'package:kuhoodemo/repo/network/networkrepositoryimpl.dart';

class SingleUserProvider extends ChangeNotifier {
  SingleUserModel userModel = SingleUserModel();

  NetworkStatus networkStatus = NetworkStatus.init;
  NetworkRepository networkRepository = NetworkRepositoryImpl();

  getSingleUser(context, {int id = 0}) async {
    try {
      networkStatus = NetworkStatus.loading;
      // notifyListeners();

      userModel = await networkRepository.getSingleUser(id: id);

      networkStatus = NetworkStatus.successful;
      notifyListeners();
    } catch (err) {
      print(err);
      networkStatus = NetworkStatus.error;
      notifyListeners();
    }
  }
}

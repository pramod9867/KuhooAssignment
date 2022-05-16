import 'package:kuhoodemo/utils/constants/network/urlconstants.dart';

class NetworkUrl {
  String getBaseUrl() {
    return UrlConstants.baseurl;
  }

  String getUserList() {
    return UrlConstants.users;
  }

  String getSingleUser({int id = 0}) {
    return UrlConstants.users + "/" + id.toString();
  }
}

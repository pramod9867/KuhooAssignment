import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuhoodemo/model/usermodel.dart';
import 'package:kuhoodemo/network/networkstatus.dart';
import 'package:kuhoodemo/provider/userprovider.dart';
import 'package:kuhoodemo/screens/userdetailscreeen.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late ScrollController _controller;
  late UserProvider userData;

  @override
  void initState() {
    super.initState();
    userData = Provider.of<UserProvider>(context, listen: false);
    userData.getUserList(context, index: 0);
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  _loadMore({int index = 0}) {
    int totalpages = userData?.userModel?.totalPages ?? 0;
    int pageCount = userData?.userModel.page ?? 0;

    print("Total Pages");
    print(totalpages);
    print("Page Count");
    print(pageCount);
    if (pageCount < totalpages &&
        _controller.position.pixels == _controller.position.maxScrollExtent) {
      userData.getUserList(context, index: pageCount + 1 ?? 0 + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userData = Provider.of<UserProvider>(context);
    return Container(
      child: userData.networkStatus == NetworkStatus.loading ||
              userData.networkStatus == NetworkStatus.init
          ? _getLoadingResponse()
          : userData.networkStatus == NetworkStatus.successful ||
                  userData.networkStatus == NetworkStatus.loadMore
              ? _getSuccessfulResponse(userProvider: userData)
              : _getErrorResponse(),
    );
  }

  Widget _getSuccessfulResponse({UserProvider? userProvider}) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          controller: _controller,
          itemCount: userProvider?.data.length,
          itemBuilder: (context, index) {
            Data? data = userProvider?.data?.elementAt(index);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  UserDetailsScreen(
                    id: data?.id??0,
                  )),
                );
              },
              child: Material(
                elevation: 2,
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Id :-"),
                                    Text(data?.id.toString() ?? ""),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("First Name :-"),
                                    Text(data?.firstName ?? ""),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Last Name :-"),
                                    Text(data?.lastName ?? ""),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.network(data?.avatar ?? "")
                      ],
                    )),
              ),
            );
          },
        )),
        NetworkStatus.loadMore == userData.networkStatus
            ? CircularProgressIndicator()
            : Container()
      ],
    );
  }

  Widget _getLoadingResponse() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getErrorResponse() {
    return Center(
      child: Text("Something Went Wrong !!"),
    );
  }
}

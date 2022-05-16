import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuhoodemo/network/networkstatus.dart';
import 'package:kuhoodemo/provider/singleuserprovider.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final int id;
  const UserDetailsScreen({Key? key, this.id = 2}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late SingleUserProvider singleUserProvider;

  @override
  void initState() {
    super.initState();
    singleUserProvider =
        Provider.of<SingleUserProvider>(context, listen: false);
    singleUserProvider.getSingleUser(context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    SingleUserProvider singleUserProvider =
        Provider.of<SingleUserProvider>(context);
    return Scaffold(
      body: Center(
        child: singleUserProvider.networkStatus == NetworkStatus.loading ||
                singleUserProvider.networkStatus == NetworkStatus.init
            ? _getLoadingResponse()
            : singleUserProvider.networkStatus == NetworkStatus.successful ||
                    singleUserProvider.networkStatus == NetworkStatus.loadMore
                ? _getSuccessfulResponse(singleUserProvider: singleUserProvider)
                : _getErrorResponse(),
      ),
    );
  }

  Widget _getSuccessfulResponse({SingleUserProvider? singleUserProvider}) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(singleUserProvider?.userModel.data?.avatar ?? ""),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("First Name :"),
                  Text(singleUserProvider?.userModel.data?.firstName ?? ""),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Last Name :"),
                  Text(singleUserProvider?.userModel.data?.lastName ?? ""),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Email Id :"),
                  Text(singleUserProvider?.userModel.data?.email ?? ""),
                ],
              ),
            )
          ]),
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

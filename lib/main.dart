import 'package:flutter/material.dart';
import 'package:kuhoodemo/provider/singleuserprovider.dart';
import 'package:kuhoodemo/provider/userprovider.dart';
import 'package:kuhoodemo/screens/userdetailscreeen.dart';
import 'package:kuhoodemo/screens/userscreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<SingleUserProvider>(
        create: (_) => SingleUserProvider()),
  ];
  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: UserListScreen()));
  }
}

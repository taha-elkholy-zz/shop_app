import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('log out'),
          onPressed: () {
            CashHelper.removeData(key: 'token').then((value) {
              // if true
              if (value) {
                navigateAndFinish(context, LoginScreen());
              }
            });
          },
        ),
      ),
    );
  }
}

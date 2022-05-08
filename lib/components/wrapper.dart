import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/sign_in_screen/sign_in_screen.dart';

import '../size_config.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<AuthProvider>(
        builder: (BuildContext context, AuthProvider auth, Widget child) {
          if (auth.loading) {
            return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
          } else {
            return !auth.isLoggedIn ? SignInScreen() :MainHomeScreen();
          }
          // return !auth.isLoggedIn ? SignInScreen() : MainHomeScreen();
        });
  }
}

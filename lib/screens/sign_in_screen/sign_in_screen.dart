import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in_screen/components/sign_in_boy.dart';
class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   title: Text("Sign In",style: TextStyle(color: Colors.black87),),
      // ),
      body: SignBody(),
    );
  }
}

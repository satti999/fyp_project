import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/screens/forgot_password_screen/components/body.dart';
import 'package:shop_app/screens/sign_in_screen/sign_in_screen.dart';


class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen() ),
            );
          },
          icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black54,),
        ),
        backgroundColor: Colors.white,
        title: Text("Forgot Password",style: TextStyle(color: Colors.black87),),
      ),
      body:  ForgotPasswordBody(),
    );
  }
}

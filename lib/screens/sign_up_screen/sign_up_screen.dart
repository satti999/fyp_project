import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up_screen/components/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
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
          icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black26,),
        ),
        backgroundColor: Colors.white70,
      ),
      body: SignUpBody(),
    );
  }
}

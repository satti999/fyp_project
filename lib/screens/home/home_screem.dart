import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/order/order_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
          body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Products", style: TextStyle(color: Colors.black54), ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading:  IconButton(
          icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black54,),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainHomeScreen() ),
            );
          },
        ),

        actions:  [
          IconButton(onPressed: null,
            icon: SvgPicture.asset("assets/icons/Search Icon.svg",color: Colors.black54,)),
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen() ),
            );
          },
            icon: SvgPicture.asset("assets/icons/shopping_cart.svg",color: Colors.black54,),),
          SizedBox(width: kDefaultPaddin/2,)

        ],

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))

      ),


      );

  }
}




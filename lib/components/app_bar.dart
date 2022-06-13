import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/screens/home/search_screen.dart';
import 'package:shop_app/screens/order/order_screen.dart';
import 'package:shop_app/constants.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title:  Text("Products", style: TextStyle(color: Colors.black54), ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0.4,
    leading:  IconButton(
      icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black54,),
      onPressed: (){
        Navigator.pop(context);
      },
    ),

    actions:  [
      IconButton(onPressed:(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen() ),
        );
      },
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

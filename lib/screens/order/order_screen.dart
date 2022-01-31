import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/order/components/body.dart';
class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(context),
      body: Orderbody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart,),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Cart", style: TextStyle(color: Colors.black54), ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.4,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black54,),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainHomeScreen() ),
          );
        },
      ),

      actions: const [
        IconButton(onPressed: null,
            icon: Icon(Icons.search)),

      ],

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))

      ),


    );

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/order/order_screen.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';
class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.black54), ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading: const IconButton(
          icon: Icon(Icons.menu,color: Colors.black54,),
          onPressed: null,
        ),

        actions:  [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen() ),
            );
          },
              icon: SvgPicture.asset("assets/icons/shopping_cart.svg",color: Colors.black54,)),
          IconButton(
              icon: SvgPicture.asset("assets/icons/Bell.svg",color: Colors.black54,),
            onPressed: (){},
          ),


        ],

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))

        ),

      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,),


    );

  }
}

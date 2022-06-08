import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/order/order_screen.dart';
import 'package:shop_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:shop_app/screens/wishlist/all_wishlist.dart';

import '../home_constans.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) :super (key: key);
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor=Colors.black26;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
          boxShadow: [

            BoxShadow(
                offset: Offset(0,-10),
                blurRadius: 20,
                color: Color(0xffdadada).withOpacity(0.15)
            )
          ]
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){

              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MainHomeScreen()), (Route<dynamic> route) => false);
            },
                icon: SvgPicture.asset("assets/icons/bar_home_icon.svg",
                  color: MenuState.home==selectedMenu
                      ?kPrimaryColor
                      :inActiveIconColor,)),
            IconButton(onPressed: (){
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  OrderScreen()), (Route<dynamic> route) => false);

            }, icon:
            SvgPicture.asset("assets/icons/cart_beg.svg",
              color: MenuState.cart==selectedMenu
                  ?kPrimaryColor
                  :inActiveIconColor,)),
            IconButton(onPressed: (){
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  const WishList()), (Route<dynamic> route) => false);

            }, icon:
            SvgPicture.asset("assets/icons/Heart Icon.svg",
              color: MenuState.wishlist==selectedMenu
                  ?kPrimaryColor
                  :inActiveIconColor,)),
            IconButton(onPressed: (){
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  ProfileScreen()), (Route<dynamic> route) => false);
            },
                icon: SvgPicture.asset("assets/icons/bar_profile_icon.svg",
                  color: MenuState.profile==selectedMenu
                      ?kPrimaryColor
                      :inActiveIconColor,)),

          ],
        ),
      ),
    );
  }
}

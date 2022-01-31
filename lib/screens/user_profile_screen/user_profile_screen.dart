import 'package:flutter/material.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/enums.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile,),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/screens/main_screen_home/components/categories_btn.dart';

import '../../../size_config.dart';
import 'app_name.dart';
import 'home_header.dart';
import 'recent_products.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(25)),
            categoriesButtons(),
            SizedBox(height: getProportionateScreenWidth(10)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
            SpecialOffers(),
          ],
        ),
      ),
    );
  }
}
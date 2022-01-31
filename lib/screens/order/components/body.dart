import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/order/components/order_categories.dart';
import 'package:shop_app/screens/payment_method/payment_method.dart';
class Orderbody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
    padding: const EdgeInsets.only(top: 15,left: 18),
          child: Text(
            "Order",
            style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold)

          ),
        ),
        OrderCategories(),
        SizedBox(height: 35,),
        EmptyPage()
      ],
    );
  }
  Widget EmptyPage()=>

      Container(
        height: 450,
        width: 450,
        child: Image.asset("assets/images/empty.png"),



      );
}

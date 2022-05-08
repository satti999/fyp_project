import 'package:flutter/material.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/order/components/body.dart';

import '../checkout_view.dart';
class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildSimpleAppBar(context,"Cart"),
      body: Orderbody(),
      bottomNavigationBar:
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              text: "Checkout",
              press: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutView()));
              },
            ),
          ),

          CustomBottomNavBar(selectedMenu: MenuState.cart,),

        ],
      )


    );
  }
  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: const Text("Cart", style: TextStyle(color: Colors.black54), ),
  //     centerTitle: true,
  //     backgroundColor: Colors.white,
  //     elevation: 0.4,
  //     leading: IconButton(
  //       icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.black54,),
  //       onPressed: (){
  //       Navigator.pop(context);
  //       },
  //     ),
  //
  //     actions: const [
  //       IconButton(onPressed: null,
  //           icon: Icon(Icons.search)),
  //
  //     ],
  //
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
  //
  //     ),
  //
  //
  //   );
  //
  // }
}

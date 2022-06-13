import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/components/cart_view_item.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/cart_view_item_model.dart';
import 'package:shop_app/screens/all_products.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/order/components/body.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

import '../checkout_view.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List cartprods;
  num totalprice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildSimpleAppBar(context, "Cart",searchbar: false),
        body: FutureBuilder(
          future: CartService().getCartProducts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            cartprods = snapshot.data.cartproducts;
            totalprice = snapshot.data.totalprice;
            return cartprods.length < 1
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('No products in cart '),
                        SizedBox(height: 10),
                        Container(
                          color: kPrimaryColor,
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            child: Text("Browse Products",
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllProducts()));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView.builder(
                          itemCount: cartprods.length,
                          itemBuilder: (BuildContext context, int index) {
                            var snapshotData =
                                cartprods[index] as CartViewItemModel;
                            return Dismissible(
                              key: Key(snapshotData.product_id.toString()),
                              onDismissed: (direction) async {
                                try {
                                  var res = await CartService()
                                      .deleteCartProduct(snapshotData.cartId);
                                  setState(() {
                                    cartprods.removeAt(index);
                                  });
                                  SnackBarService()
                                      .showSnackBar(context, res.toString());
                                } catch (Err) {
                                  SnackBarService()
                                      .showSnackBar(context, Err.toString());
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CartViewItem(
                                      cartViewItem: snapshotData,
                                      quantityHandler: (quan) async {
                                        try {
                                          var res = await CartService()
                                              .updateCartProduct({
                                            "cart_id": snapshotData.cartId,
                                            "quantity": quan
                                          });
                                          SnackBarService().showSnackBar(
                                              context, res.toString());
                                          setState(() {
                                            // snapshotData.quantity = quan;
                                          });
                                        } catch (err) {
                                          SnackBarService().showSnackBar(
                                              context, err.toString());
                                        }
                                      })),
                            );
                            // return ListTile(
                            //   contentPadding: EdgeInsets.all(10),
                            //   leading: Image.network("${IMAGESURL}${snapshotData.image}"),
                            //   title: Text(
                            //     snapshotData.productName
                            //   ),
                            //   trailing: Text(
                            //     snapshotData.quantity.toString()
                            //   ),
                            // );
                          }),
                      ListTile(
                        title: Text("Total:",style: headingStyle),
                        trailing: Text("\$$totalprice",style: headingStyle),
                      )
                    ],
                  );
          },
        ),

        // Orderbody(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultButton(
                text: "Checkout",
                press: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CheckoutView()));
                },
              ),
            ),
            CustomBottomNavBar(
              selectedMenu: MenuState.cart,
            ),
          ],
        ));
  }
}

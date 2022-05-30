import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/cart_view_item.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/cart_view_item_model.dart';
import 'package:shop_app/screens/order/components/order_categories.dart';
import 'package:shop_app/screens/payment_method/payment_method.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

class Orderbody extends StatefulWidget {
  @override
  State<Orderbody> createState() => _OrderbodyState();
}

class _OrderbodyState extends State<Orderbody> {
  List cartprods;
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
      future: CartService().getCartProducts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
         cartprods = snapshot.data.cartproducts;
        return ListView.builder(
            itemCount: cartprods.length,
            itemBuilder: (BuildContext context, int index) {
              var snapshotData = cartprods[index] as CartViewItemModel;
              return Dismissible(
                key: Key(snapshotData.product_id.toString()),
                onDismissed: (direction) async {
                  try {
                    var res = await CartService()
                        .deleteCartProduct(snapshotData.cartId);
                    setState(() {
                      cartprods.removeAt(index);
                    });
                    SnackBarService().showSnackBar(context, res.toString());
                  } catch (Err) {
                    SnackBarService().showSnackBar(context, Err.toString());
                  }
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(CupertinoIcons.trash,color: Colors.white,),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CartViewItem(cartViewItem: snapshotData)),
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
            });
      },
    );
  }

  Widget EmptyPage() => Container(
        height: 450,
        width: 450,
        child: Image.asset("assets/images/empty.png"),
      );
}

import 'package:flutter/material.dart';
import 'package:shop_app/model/cart_view_item_model.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

import '../constants.dart';

class CartViewItem extends StatefulWidget {
  CartViewItemModel cartViewItem;
  var quantityHandler;

  CartViewItem({Key key, this.cartViewItem,this.quantityHandler}) : super(key: key);

  @override
  _CartViewItemState createState() => _CartViewItemState();
}

class _CartViewItemState extends State<CartViewItem> {
  @override
  Widget build(BuildContext context) {
    // quan=widget.cartViewItem.quantity;
    return Row(
      children: [
        Column(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Image.network(
                  "${IMAGESURL}${widget.cartViewItem.image}",
                  fit: BoxFit.cover,
                )),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cartViewItem.productName.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("${widget.cartViewItem.price.toString()} \$"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 120,
                        height: 30,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 32,
                              child: IconButton(
                                  onPressed: () async {
                                    if(widget.cartViewItem.quantity > 1){
                                      int quan = widget.cartViewItem.quantity;
                                      quan--;
                                     widget.quantityHandler(quan);
                                    }

                                    // try{
                                    //   int quan= widget.cartViewItem.quantity;
                                    //   quan--;
                                    //   var res=await CartService().updateCartProduct({
                                    //     "cart_id":widget.cartViewItem.cartId,
                                    //     "quantity":quan
                                    //   });
                                    //   SnackBarService().showSnackBar(context, res.toString());
                                    //   setState(() {
                                    //     widget.cartViewItem.quantity=quan;
                                    //   });
                                    // }
                                    // catch(err){
                                    //  SnackBarService().showSnackBar(context, err.toString());
                                    // }
                                  },
                                  icon: Icon(Icons.remove, size: 15)),
                            ),
                            Text("${widget.cartViewItem.quantity.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 40,
                              height: 32,
                              child: IconButton(
                                  onPressed: () {
                                    int quan = widget.cartViewItem.quantity;
                                    quan++;
                                    widget.quantityHandler(quan);
                                    // setState(() {
                                    //   widget.cartViewItem.quantity--;
                                    //
                                    // });
                                  },
                                  icon: Icon(Icons.add, size: 15)),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  updateQuantity(quan) async {
    try {
      var res = await CartService().updateCartProduct(
          {"cart_id": widget.cartViewItem.cartId, "quantity": quan});
      SnackBarService().showSnackBar(context, res.toString());
      setState(() {
        widget.cartViewItem.quantity = quan;
      });
    } catch (err) {
      SnackBarService().showSnackBar(context, err.toString());
    }
  }
}

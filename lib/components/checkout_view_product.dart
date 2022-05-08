import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product_model.dart';


class CheckoutViewProduct extends StatefulWidget {
  int quantity;
  int id;
  Function ondelete;
  var product;
   CheckoutViewProduct({Key key,this.quantity,this.product,this.id,this.ondelete}) : super(key: key);

  @override
  State<CheckoutViewProduct> createState() => _CheckoutViewProductState();
}

class _CheckoutViewProductState extends State<CheckoutViewProduct> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${widget.quantity}x"),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.product.name}"),
            Text("\$${widget.product.price}"),
          ],
        ),
      ),
      trailing: InkWell(
        onTap: widget.ondelete,

        child: Icon(CupertinoIcons.trash,color: Colors.red,),
      ),
    );
  }
}

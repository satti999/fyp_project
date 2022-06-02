import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutViewProduct extends StatefulWidget {
  int quantity;
  int id;
  Function ondelete;
  var product;

  CheckoutViewProduct(
      {Key key, this.quantity, this.product, this.id, this.ondelete})
      : super(key: key);

  @override
  State<CheckoutViewProduct> createState() => _CheckoutViewProductState();
}

class _CheckoutViewProductState extends State<CheckoutViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.quantity!=null && widget.quantity>0 ? "${widget.quantity}x": ""),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.product.name}"),
                  Text("\$${widget.product.price}"),
                ],
              ),
            ),
          ),
              InkWell(
                onTap: widget.ondelete,

                child: Icon(CupertinoIcons.trash,color: Colors.red,),
              ),
        ],
      ),
    );
    //   ListTile(
    //   leading: Container(color: Colors.red,child: Text("${widget.quantity}x")),
    //   title: Container(
    //     color: Colors.yellow,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text("${widget.product.name}"),
    //           Text("\$${widget.product.price}"),
    //         ],
    //       ),
    //     ),
    //   ),
    //   trailing: Container(
    //     color: Colors.blue,
    //     child:
    //     InkWell(
    //       onTap: widget.ondelete,
    //
    //       child: Icon(CupertinoIcons.trash,color: Colors.red,),
    //     ),
    //   ),
    // );
  }
}

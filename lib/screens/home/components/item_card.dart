import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/model/Product.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';

class ItemCard extends StatefulWidget {
  final ProductModel product;
  final Function press;

  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool cartLoading =false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                // color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Hero(
                  tag: "${widget.product.id}",
                  child: widget.product.image != null
                      ? Image.network(
                          IMAGESURL + widget.product.image.toString().split(',')[0])
                      : Text("No image")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              widget.product.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${widget.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFFFF6F57)),
              ),
              // InkWell(
              //   onTap:cartLoading? null: () async
              //   {
              //     try{
              //       setState(() {
              //         cartLoading=true;
              //       });
              //       var res=await CartService().addToCart({
              //         "product_id":widget.product.id,
              //         "quantity":1
              //       });
              //       SnackBarService().showSnackBar(context, res.toString());
              //
              //     }
              //     catch(Err){
              //       SnackBarService().showSnackBar(context, Err.toString());
              //     }
              //     finally{
              //       setState(() {
              //         cartLoading=false;
              //       });
              //     }
              //
              //
              //
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(getProportionateScreenWidth(6)),
              //     height: getProportionateScreenWidth(26),
              //     width: getProportionateScreenWidth(26),
              //     decoration: const BoxDecoration(
              //         color: Color(0xFFFF6F57),
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(4.0),
              //             topRight: Radius.circular(4.0),
              //             bottomLeft: Radius.circular(4.0),
              //             bottomRight: Radius.circular(4.0))),
              //     child: cartLoading? CircularProgressIndicator(color: Colors.white): SvgPicture.asset(
              //       "assets/icons/shopping_cart.svg",
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

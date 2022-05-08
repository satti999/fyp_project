import 'package:flutter/material.dart';
import 'package:shop_app/components/product_single_view.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/Product.dart';
import 'package:shop_app/model/product_model.dart';
import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final ProductModel product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return ProductSingleView(product: product);
    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       SizedBox(
    //         height: size.height,
    //         child: Stack(
    //           children: <Widget>[
    //             Container(
    //               margin: EdgeInsets.only(top: size.height * 0.3),
    //               padding: EdgeInsets.only(
    //                 top: size.height * 0.13,
    //                 left: kDefaultPaddin,
    //                 right: kDefaultPaddin,
    //               ),
    //               // height: 500,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(24),
    //                   topRight: Radius.circular(24),
    //                 ),
    //               ),
    //               child: Column(
    //                 children:  <Widget>[
    //                   // ColorAndSize(product: product),
    //                   SizedBox(height: kDefaultPaddin / 2),
    //                   Description(description: product.description),
    //                   SizedBox(height: kDefaultPaddin / 2),
    //                   SizedBox(height: kDefaultPaddin / 2),
    //                   AddToCart(product: product),
    //                 ],
    //               ),
    //             ),
    //             ProductTitleWithImage(product: product)
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

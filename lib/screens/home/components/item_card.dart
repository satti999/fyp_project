import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/model/Product.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
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
                color: product.color,
                borderRadius: BorderRadius.circular(16),

              ),

              child: Hero(
                tag: "${product.id}",
                child: Image.asset(product.image),

              ),


            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFFF6F57)),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                  height: getProportionateScreenWidth(26),
                  width: getProportionateScreenWidth(26),
                  decoration: BoxDecoration(
                      color: Color(0xFFFF6F57),
                      borderRadius:  new BorderRadius.only(
                          topLeft: const Radius.circular(4.0),
                          topRight: const Radius.circular(4.0),
                          bottomLeft: const Radius.circular(4.0),
                          bottomRight: const Radius.circular(4.0)
                      )

                  ),
                  child: SvgPicture.asset(
                    "assets/icons/shopping_cart.svg",
                  ),

                ),
              ),
            ],



          ),

        ],
      ),
    );
  }
}

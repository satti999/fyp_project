import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/home_product.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                    height: getProportionateScreenWidth(32),
                    width: getProportionateScreenWidth(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F57),
                        borderRadius:  new BorderRadius.only(
                          topLeft:  Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                          bottomLeft:  Radius.circular(4.0),
                            bottomRight:  Radius.circular(4.0)
                        )

                    ),
                    child: SvgPicture.asset(
                      "assets/icons/shopping_cart.svg",
                    ),

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

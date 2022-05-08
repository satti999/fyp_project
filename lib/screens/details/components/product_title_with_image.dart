import 'package:flutter/material.dart';
import 'package:shop_app/model/Product.dart';
import 'package:shop_app/model/product_model.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1/1,
                  child: Hero(
                      tag: "${product.id}",
                      child: product.image != null
                          ? Image.network(
                              IMAGESURL + product.image.toString().split(',')[0],
                              fit: BoxFit.contain)
                          : Text("No image")

                      // Image.asset(
                      //   product.image,
                      //   fit: BoxFit.fill,
                      // ),
                      ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

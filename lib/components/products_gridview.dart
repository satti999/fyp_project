import 'package:flutter/material.dart';
import 'package:shop_app/components/product_details_view.dart';
import 'package:shop_app/screens/home/components/item_card.dart';

import '../constants.dart';

class ProductsGridView extends StatelessWidget {

  var prods;
   ProductsGridView({Key key,this.prods}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return                       Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddin),
      child:
      GridView.builder(
          itemCount: prods.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPaddin,
            crossAxisSpacing: kDefaultPaddin,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ItemCard(
            product: prods[index],
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: prods[index],
                  ),
                )),
          )),
    );

  }

}

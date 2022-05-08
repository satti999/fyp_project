import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/products_gridview.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prods = Provider.of<List<ProductModel>>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: prods == null
          ? const Center(
              child: CircularProgressIndicator(
              color: kPrimaryColor,
            ))
          : ProductsGridView(
              prods: prods,
            ),
    );
  }
}

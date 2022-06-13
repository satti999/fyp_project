import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/model/product_model.dart';

import '../../components/product_details_view.dart';
import '../../size_config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> res = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<List<ProductModel>>(context);
    return Scaffold(
      appBar: buildSimpleAppBar(context, "Search Products", searchbar: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                onChanged: (val) {
                  setState(() {
                    if (val.isEmpty) {
                      res = [];
                    } else {
                      res = prods
                          .where((product) => product.name
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                    }
                  });
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(25),
                        vertical: getProportionateScreenWidth(16)),
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search))),
            Expanded(
              child: res.isEmpty
                  ? const Center(
                      child: Text("Nothing found, Start typing products name"))
                  : ListView.builder(
                      itemCount: res.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                          product: res[index])));
                            },
                            title: Text(res[index].name));
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

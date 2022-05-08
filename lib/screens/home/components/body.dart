import 'package:flutter/material.dart';
import 'package:shop_app/components/products_gridview.dart';
import 'package:shop_app/screens/main_screen_home/components/categories_btn.dart';
import 'package:shop_app/services/category_service.dart';

class Body extends StatelessWidget {
  int categoryId;
  String categoryName;

  Body({this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait<dynamic>([
          CategoryService().getSubcategoryUsingParentId(categoryId),
          CategoryService().getCategoryProducts(categoryId)
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var cats = snapshot.data[0];
          var prods = snapshot.data[1];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 18),
                child: Text(
                  categoryName.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              cats != null && cats.length > 0
                  ? categoriesButtons(categories: cats)
                  : const Text(''),

              prods != null && prods.length > 0
                  ? Expanded(child: ProductsGridView(prods: prods)
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: kDefaultPaddin),
                      //   child:
                      //   GridView.builder(
                      //       itemCount: prods.length,
                      //       gridDelegate:
                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 2,
                      //         mainAxisSpacing: kDefaultPaddin,
                      //         crossAxisSpacing: kDefaultPaddin,
                      //         childAspectRatio: 0.75,
                      //       ),
                      //       itemBuilder: (context, index) => ItemCard(
                      //             product: prods[index],
                      //             press: () => Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => ProductDetailPage(
                      //                     product: prods[index],
                      //                   ),
                      //                 )),
                      //           )),
                      // ),
                      )
                  : const Center(child: Text('No products found'))
              // Categories(parentId: categoryId,),
            ],
          );
        });
  }
}

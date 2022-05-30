import 'package:flutter/material.dart';
import 'package:shop_app/components/products_gridview.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/screens/main_screen_home/components/categories_btn.dart';
import 'package:shop_app/services/category_service.dart';

class Body extends StatelessWidget {
  int categoryId;
  String categoryName;

  Body({this.categoryId, this.categoryName});

  myFuture() async {
    //find currentcat products
    //find subcategories
    //find subcat products
    //merge two lists/
    //sort them using product id
    var products = await CategoryService().getCategoryProducts(categoryId);
    var subcategories =
        await CategoryService().getSubcategoryUsingParentId(categoryId);
    for (var i = 0; i < subcategories.length; i++) {
      CategoryModel category = subcategories[i];
      var subproducts =
          await CategoryService().getCategoryProducts(category.id);
      products = [...products, ...subproducts];
    }
    return {"products": products, "subcategories": subcategories};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                snapshot.data['subcategories'] != null &&
                        snapshot.data['subcategories'].length > 0
                    ? categoriesButtons(
                        categories: snapshot.data['subcategories'])
                    : const Text(''),
                snapshot.data['products'] != null &&
                        snapshot.data['products'].length > 0
                    ? Expanded(
                        child:
                            ProductsGridView(prods: snapshot.data['products']))
                    : const Center(child: Text('No products found')),
              ]
          );
        });
    // return FutureBuilder(
    //     future: Future.wait<dynamic>([
    //       CategoryService().getSubcategoryUsingParentId(categoryId),
    //       CategoryService().getCategoryProducts(categoryId)
    //     ]),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //
    //
    //       var cats = snapshot.data[0];
    //       var prods = snapshot.data[1];
    //       return  Text("${cats[0].id}");
    //       // return Column(
    //       //   crossAxisAlignment: CrossAxisAlignment.start,
    //       //   children: <Widget>[
    //       //     Padding(
    //       //       padding: const EdgeInsets.only(top: 15, left: 18),
    //       //       child: Text(
    //       //         categoryName.toString(),
    //       //         style: Theme.of(context)
    //       //             .textTheme
    //       //             .headline5
    //       //             .copyWith(fontWeight: FontWeight.bold),
    //       //       ),
    //       //     ),
    //       //
    //       //     cats != null && cats.length > 0
    //       //         ? categoriesButtons(categories: cats)
    //       //         : const Text(''),
    //       //
    //       //     prods != null && prods.length > 0
    //       //         ? Expanded(child: ProductsGridView(prods: prods)
    //       //             // Padding(
    //       //             //   padding: const EdgeInsets.symmetric(
    //       //             //       horizontal: kDefaultPaddin),
    //       //             //   child:
    //       //             //   GridView.builder(
    //       //             //       itemCount: prods.length,
    //       //             //       gridDelegate:
    //       //             //           const SliverGridDelegateWithFixedCrossAxisCount(
    //       //             //         crossAxisCount: 2,
    //       //             //         mainAxisSpacing: kDefaultPaddin,
    //       //             //         crossAxisSpacing: kDefaultPaddin,
    //       //             //         childAspectRatio: 0.75,
    //       //             //       ),
    //       //             //       itemBuilder: (context, index) => ItemCard(
    //       //             //             product: prods[index],
    //       //             //             press: () => Navigator.push(
    //       //             //                 context,
    //       //             //                 MaterialPageRoute(
    //       //             //                   builder: (context) => ProductDetailPage(
    //       //             //                     product: prods[index],
    //       //             //                   ),
    //       //             //                 )),
    //       //             //           )),
    //       //             // ),
    //       //             )
    //       //         : const Center(child: Text('No products found'))
    //       //     // Categories(parentId: categoryId,),
    //       //   ],
    //       // );
    //     });
  }
}

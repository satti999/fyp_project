import 'package:flutter/material.dart';
import 'package:shop_app/components/home_product_card.dart';
import 'package:shop_app/model/home_product.dart';
import 'package:shop_app/screens/all_products.dart';
import 'package:shop_app/screens/home/components/item_card.dart';
import 'package:shop_app/services/product_service.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),

      child: Column(
        children: [
          SectionTitle(title: "Recent Products", press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            const AllProducts()
            ));
          }),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          SizedBox(
            height: 250,
            child:
            FutureBuilder(
              future: ProductService().getRecentProducts(),
              builder: (context,snapshot){
                if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: snapshot.data[index]);
                    });
              }
            )


          )
        ],
      ),
    );

    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Recent Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        FutureBuilder(
            future: ProductService().getRecentProducts(),
            builder: (context,snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                return ItemCard(product: snapshot.data[index]);
            });
            // return SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       ...List.generate(
            //         demoProducts.length,
            //             (index) {
            //           if (demoProducts[index].isPopular)
            //             return  ProductCard(product: demoProducts[index]);
            //
            //           return const  SizedBox
            //               .shrink(); // here by default width and height is 0
            //         },
            //       ),
            //       SizedBox(width: getProportionateScreenWidth(20)),
            //     ],
            //   ),
            // );

            }),


      ],
    );
  }
}

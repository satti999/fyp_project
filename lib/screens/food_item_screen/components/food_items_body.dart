import 'package:flutter/material.dart';
import 'package:shop_app/screens/food_item_screen/components/food_categories.dart';
class FoodItemBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 18),
          child: Text(
              "Food Items",
              style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold)

          ),
        ),
        FoodItemsCategories(),
        //This an optional Remove it while adding categories of foods
        SizedBox(height: 35,),
        EmptyPage()


        //PaymentMethod(),
      ],
    );
  }
  Widget EmptyPage()=>

      Container(
    height: 450,
    width: 450,
    child: Image.asset("assets/images/empty.png"),
    


  );
}

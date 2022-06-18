import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/screens/food_item_screen/food_item_screen.dart';
import 'package:shop_app/screens/home/home_screem.dart';

class categoriesButtons extends StatelessWidget {
  List<dynamic> categories;

  categoriesButtons({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var categories = Provider.of<List<CategoryModel>>(context);
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: categories == null
              ? Text("No data found")
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Category_btn(context, categories[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 15,
                      );
                    },
                  ),
                )
          // Consumer<List<Category>>(
          //     builder: (context,value,_) {
          //   return value == null
          //       ? CircularProgressIndicator()
          //       :
          // Row(
          //     children: categories
          //         .map((category) => Category_btn(context, category))
          //         .toList()
          //     // [
          //     //
          //     //   Garments_btn(context),
          //     //   SizedBox(
          //     //     width: 15,
          //     //   ),
          //     //   Electronics_btn(context),
          //     //   SizedBox(
          //     //     width: 15,
          //     //   ),
          //     //   Cosmetics_btn(),
          //     //   SizedBox(
          //     //     width: 15,
          //     //   ),
          //     //   Food_item_btn(context),
          //     //   SizedBox(
          //     //     width: 15,
          //     //   ),
          //     //   Non_Food_item_btn(),
          //     // ],
          //     )
          // }
          // child: Row(
          //   children: [
          //
          //     Garments_btn(context),
          //     SizedBox(width: 15,),
          //     Electronics_btn(context),
          //     SizedBox(width: 15,),
          //     Cosmetics_btn(),
          //     SizedBox(width: 15,),
          //     Food_item_btn(context),
          //     SizedBox(width: 15,),
          //     Non_Food_item_btn(),
          //   ],
          // ),
          // ),
          ),
    );
  }

  Widget Category_btn(BuildContext context, CategoryModel category) =>
      InkWell(
        onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        categoryId: category.id, categoryName: category.title)),
              );
        },
        child: Container(
            height: 46,
            width: 122,
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  )
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                category.icon != null
                    ? Image.network(
                        IMAGESURL + category.icon,
                        height: 30,
                        width: 30,
                      )
                    : Image.asset(
                        "assets/icons/garments.png",
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(category.title)
              ],
            )
            // TextButton.icon(
            //   label: Text(
            //     category.title,
            //     style: TextStyle(color: Colors.black54),
            //   ),
            //   icon: ImageIcon(
            //     category.icon != null
            //         ? NetworkImage(IMAGESURL + category.icon)
            //         : const AssetImage(
            //             "assets/icons/garments.png",
            //           ),
            //     color: kPrimaryColor,
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => HomeScreen(
            //               categoryId: category.id, categoryName: category.title)),
            //     );
            //   },
            // ),
            ),
      );

// Widget Garments_btn(BuildContext context) => Container(
//       height: 46,
//       width: 122,
//       decoration: BoxDecoration(
//           color: Color(0xFFF5F5F5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(0, 1),
//             )
//           ]),
//       child: TextButton.icon(
//         label: const Text(
//           "Garments",
//           style: TextStyle(color: Colors.black54),
//         ),
//         icon: const ImageIcon(
//           AssetImage(
//             "assets/icons/garments.png",
//           ),
//           color: Colors.black54,
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         },
//       ),
//     );
//
// Widget Electronics_btn(BuildContext context) => Container(
//       height: 46,
//       width: 122,
//       decoration: BoxDecoration(
//           color: Color(0xFFF5F5F5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(0, 1),
//             )
//           ]),
//       child: TextButton.icon(
//         label: const Text(
//           "Electronics",
//           style: TextStyle(color: Colors.black54),
//         ),
//         icon: const ImageIcon(
//           AssetImage(
//             "assets/icons/electronics.png",
//           ),
//           color: Colors.black54,
//         ),
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Coming soon"),
//           ));
//         },
//       ),
//     );
//
// Widget Cosmetics_btn() => Container(
//       height: 46,
//       width: 122,
//       decoration: BoxDecoration(
//           color: Color(0xFFF5F5F5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(0, 1),
//             )
//           ]),
//       child: TextButton.icon(
//         label: const Text(
//           "Cosmetics",
//           style: TextStyle(color: Colors.black54),
//         ),
//         icon: const ImageIcon(
//           AssetImage(
//             "assets/icons/cosmetics.png",
//           ),
//           color: Colors.black54,
//         ),
//         onPressed: () {},
//       ),
//     );
//
// Widget Food_item_btn(BuildContext context) => Container(
//       height: 46,
//       width: 122,
//       decoration: BoxDecoration(
//           color: Color(0xFFF5F5F5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(0, 1),
//             )
//           ]),
//       child: TextButton.icon(
//         label: const Text(
//           "Food Items",
//           style: TextStyle(color: Colors.black54),
//         ),
//         icon: const ImageIcon(
//           AssetImage(
//             "assets/icons/grocery.png",
//           ),
//           color: Colors.black54,
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => FoodItems()),
//           );
//         },
//       ),
//     );
//
// Widget Non_Food_item_btn() => Container(
//       height: 46,
//       width: 122,
//       decoration: BoxDecoration(
//           color: Color(0xFFF5F5F5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(0, 1),
//             )
//           ]),
//       child: TextButton.icon(
//         label: const Text(
//           "Non Food Items",
//           style: TextStyle(color: Colors.black54),
//         ),
//         icon: const ImageIcon(
//           AssetImage(
//             "assets/icons/non_food_icon.png",
//           ),
//           color: Colors.black54,
//         ),
//         onPressed: () {},
//       ),
//     );
}

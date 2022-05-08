import 'package:flutter/material.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/services/category_service.dart';

import '../../../constants.dart';

class Categories extends StatefulWidget {
  int parentId;
  @override
  _CategoriesState createState() => _CategoriesState();

  Categories({Key key,this.parentId});
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Shirts", "T-Shirts", "Coat", "Jeans","Pents"];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: CategoryService().getSubcategoryUsingParentId(widget.parentId),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return  snapshot.data.length > 0?   Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => buildCategory(index,snapshot.data[index]),
              ),
            ),
          ):const Text('');

        },
      );


  }

  Widget buildCategory(int index,CategoryModel category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              category.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.deepOrangeAccent : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

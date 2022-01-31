import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/Product.dart';
import 'package:shop_app/screens/details/components/body.dart';
import 'package:shop_app/screens/home/home_screem.dart';
class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const  Text("Details"),
      centerTitle: true,
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen() ),
          );
        },
        icon: SvgPicture.asset("assets/icons/Back ICon.svg",color: Colors.white,),

      ),
     actions: const <Widget>[
     IconButton(onPressed: null,
        icon: Icon(Icons.search,color: Colors.white)),
       IconButton(onPressed: null,
            icon: Icon(Icons.shopping_cart_outlined,color: Colors.white)),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}


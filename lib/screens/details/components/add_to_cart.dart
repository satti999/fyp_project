import 'package:flutter/material.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';
import '../../../constants.dart';

class AddToCart extends StatefulWidget {

  int _quan=1;
   AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // CounterWithFavBtn(),
          Row(
            children: [
             buildOutlineButton(press:()=> subQuan(),icon: Icons.remove),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget._quan.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ),
              buildOutlineButton(press:()=> addQuan(),icon: Icons.add),
            ],
          ),
          SizedBox(
            height: 50,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color(0xFFFF4C2F),
              onPressed:
              _isloading?null : () async{
                try{
                  setState(() {
                    _isloading=true;
                  });
                  var res=await CartService().addToCart({
                    "product_id":widget.product.id,
                    "quantity":widget._quan
                  });
                  SnackBarService().showSnackBar(context, res.toString());

                }
                catch(Err){
                  SnackBarService().showSnackBar(context, Err.toString());
                } finally{
                  setState(() {
                    _isloading=false;
                  });
                }


              },
              child: Text(
               _isloading ?"Loading..." : "add to cart".toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addQuan(){
    setState(() {
      widget._quan++;

    });
  }
  subQuan(){
    setState(() {

      widget._quan >1 ?widget._quan--:'';

    });
  }
  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}

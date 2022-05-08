import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/product_details_view.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/home_product.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool cartLoading=false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage(product: widget.product)),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(widget.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network("${IMAGESURL}${widget.product.image.split(",")[0]}"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    onTap:
                    cartLoading? null: () async{
                      try{
                        setState(() {
                          cartLoading=true;
                        });
                        var res=await CartService().addToCart({
                          "product_id":widget.product.id,
                          "quantity":1
                        });
                        SnackBarService().showSnackBar(context, res.toString());

                      }
                      catch(Err){
                        SnackBarService().showSnackBar(context, Err.toString());
                      }
                      finally{
                        setState(() {
                          cartLoading=false;
                        });
                      }



                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                      height: getProportionateScreenWidth(32),
                      width: getProportionateScreenWidth(32),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6F57),
                          borderRadius:  BorderRadius.only(
                            topLeft:  Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                            bottomLeft:  Radius.circular(4.0),
                              bottomRight:  Radius.circular(4.0)
                          )

                      ),
                      child:cartLoading? CircularProgressIndicator(
                        color: Colors.white,
                      ) : SvgPicture.asset(
                        "assets/icons/shopping_cart.svg",
                      ),

                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

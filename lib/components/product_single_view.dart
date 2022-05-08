import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/details/components/description.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

class ProductSingleView extends StatefulWidget {
  ProductModel product;

  ProductSingleView({Key key, this.product}) : super(key: key);

  @override
  State<ProductSingleView> createState() => _ProductSingleViewState();
}

class _ProductSingleViewState extends State<ProductSingleView> {
  bool _isloading=false;
  int quan = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Divider(
              thickness: 4,
              indent: 160,
              endIndent: 170,
            ),
            // verticalSpaceSmall,
            Center(
              child: Image.network(
                "${IMAGESURL}${widget.product.image}",
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.price.toString() + "\$",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Description(description: "${widget.product.description}"),
            const Divider(
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (quan > 1) {
                              quan--;
                            }
                          });
                          // model.subQuantity();
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 18,
                        )),
                  ),
                  Text("${quan.toString()}"),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    maxRadius: 18,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            quan++;
                          });
                          // model.addQuantity();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 18,
                        )),
                  ),
                  MaterialButton(
                    disabledColor: Colors.grey,
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    onPressed: _isloading
                        ? null
                        : () async {
                            try {
                              setState(() {
                                _isloading = true;
                              });
                              var res = await CartService().addToCart({
                                "product_id": widget.product.id,
                                "quantity": quan
                              });
                              SnackBarService()
                                  .showSnackBar(context, res.toString());
                            } catch (Err) {
                              SnackBarService()
                                  .showSnackBar(context, Err.toString());
                            } finally {
                              setState(() {
                                _isloading = false;
                              });
                            }
                          },
                    child: Text(_isloading ? "Loading...":"ADD TO CART",
                        style: TextStyle(color: Colors.white)),
                    // color: kcBrandColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

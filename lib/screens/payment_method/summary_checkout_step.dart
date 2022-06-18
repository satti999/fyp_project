import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/checkout_provider.dart';

import '../../components/checkout_view_product.dart';
import '../../home_constans.dart';
import '../../services/cart_service.dart';
import '../../services/checkout_service.dart';
import '../../services/snackbar_service.dart';

class SummaryCheckoutStep extends StatefulWidget {
  const SummaryCheckoutStep({Key key}) : super(key: key);

  @override
  State<SummaryCheckoutStep> createState() => _SummaryCheckoutStepState();
}

class _SummaryCheckoutStepState extends State<SummaryCheckoutStep> {
  bool _isloading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    fetchCheckOutData();
    // Add Your Code here.

    // });
  }

  fetchCheckOutData() async {
    var p = Provider.of<CheckoutProvider>(context, listen: false);
    await p.fetchCheckoutData();
    setState(() {
      _isloading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<CheckoutProvider>(context);
    if (_isloading || p.checkoutData == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: kPrimaryColor,
      ));
    }


    else {
      var snapShotProducts = p.checkoutData.products;
      return snapShotProducts == null || snapShotProducts.isEmpty
          ? const Text('Nothing to checkout')
          : SizedBox(
              height: MediaQuery.of(context).size.height * 65 / 100,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.builder(
                    itemCount: snapShotProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      int quan = snapShotProducts[index]['quantity'];
                      var product = snapShotProducts[index]['product'];
                      int id = snapShotProducts[index]['id'];
                      return CheckoutViewProduct(
                          ondelete: () async {
                            try {
                              var res =
                                  await CartService().deleteCartProduct(id);
                              setState(() {
                                snapShotProducts.removeAt(index);
                              });
                              SnackBarService()
                                  .showSnackBar(context, res.toString());
                            } catch (Err) {
                              SnackBarService()
                                  .showSnackBar(context, Err.toString());
                            }
                          },
                          id: id,
                          quantity: quan,
                          product: product);
                    },
                  ),
                  ListTile(
                    leading: Text("Total:", style: headingStyle),
                    trailing:
                        Text("\$${p.checkoutData.total}", style: headingStyle),
                  ),
                ],
              ),
            );
    }
  }
}

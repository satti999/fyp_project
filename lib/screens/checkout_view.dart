import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/checkout_view_product.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/providers/checkout_provider.dart';
import 'package:shop_app/screens/main_screen_home/main_home_screen.dart';
import 'package:shop_app/screens/payment_method/payment_checkout_step.dart';
import 'package:shop_app/screens/payment_method/shipping_checkout_step.dart';
import 'package:shop_app/screens/payment_method/summary_checkout_step.dart';
import 'package:shop_app/services/checkout_service.dart';
import 'package:shop_app/services/payment_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _stepIndex = 0;

  num total = 0;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildSimpleAppBar(context, "Checkout", searchbar: false,onbackPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainHomeScreen()));
        }),
        body: Theme(
          data: ThemeData(
              colorScheme: const ColorScheme.light(primary: kPrimaryColor)),
          child: Stepper(
            elevation: 0,
            onStepCancel: () {
              if (_stepIndex > 0) {
                setState(() {
                  _stepIndex -= 1;
                });
              }
            },
            onStepContinue: () {
              setState(() {
                _stepIndex += 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _stepIndex = index;
              });
            },
            currentStep: _stepIndex,
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return DefaultButton(
                press: isloading
                    ? null
                    : () async {
                        var pr = Provider.of<CheckoutProvider>(context,
                            listen: false);

                        if (_stepIndex == 2) {
                          //delivery tab

                          if (pr.formKey.currentState.validate()) {
                              try {
                                if (pr.paymentType == paymentTypeEnum.Stripe) {
                                 await PaymentService().makePayment(
                                      amount: "${pr.checkoutData.total}",
                                      currency: "USD",
                                      context: context,
                                    name: pr.shippingDetails['name'],
                                    country: pr.shippingDetails['country'],
                                    city: pr.shippingDetails['city'],
                                    state: pr.shippingDetails['state'],
                                   address: pr.shippingDetails['address']

                                  );
                                 await placeOrder();
                                } else {
                                  await placeOrder();
                                }
                              } catch (Err) {
                                SnackBarService()
                                    .showSnackBar(context, Err.toString());
                              } finally {
                                setState(() {
                                  isloading = false;
                                });
                              }

                          }
                        } else if (_stepIndex == 1) {
                          //payment tab
                          if(pr.paymentType==paymentTypeEnum.Stripe || pr.paymentType==paymentTypeEnum.COD){
                            details.onStepContinue();
                          }
                          else{
                            await placeOrder();
                          }

                        } else {
                          details.onStepContinue();
                        }
                      },
                text: isloading ? 'Loading...' : 'Next',
              );
            },
            type: StepperType.horizontal,
            steps: [
              Step(
                  isActive: _stepIndex == 0,
                  title: const Text("Summary"),
                  content: const SummaryCheckoutStep()),

              Step(
                  isActive: _stepIndex == 1,
                  title: const Text("Payment"),
                  content: const PaymentCheckoutStep()),
              Step(
                  isActive: _stepIndex == 2,
                  title: const Text("Delivery"),
                  content:  const ShippingCheckoutStep()),
            ],
          ),
        )

        // FutureBuilder(
        //     future: CheckoutService().getCheckout(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //             child: CircularProgressIndicator(color: kPrimaryColor));
        //       } else {
        //         var snapShotProducts = snapshot.data.products;
        //         return snapShotProducts == null ||
        //             snapShotProducts.length == null ||
        //             snapShotProducts.length < 1
        //             ? const Center(
        //           child: Text("Nothing to checkout"),
        //         )
        //             : Stack(
        //           alignment: Alignment.bottomCenter,
        //           children: [
        //             ListView.builder(
        //               itemCount: snapShotProducts.length,
        //               itemBuilder: (BuildContext context, int index) {
        //                 int quan = snapShotProducts[index]['quantity'];
        //                 var product = snapShotProducts[index]['product'];
        //                 int id = snapShotProducts[index]['id'];
        //                 return CheckoutViewProduct(
        //                     ondelete: () async {
        //                       try {
        //                         var res = await CartService()
        //                             .deleteCartProduct(id);
        //                         setState(() {
        //                           snapShotProducts.removeAt(index);
        //                         });
        //                         SnackBarService().showSnackBar(
        //                             context, res.toString());
        //                       } catch (Err) {
        //                         SnackBarService().showSnackBar(
        //                             context, Err.toString());
        //                       }
        //                     },
        //                     id: id,
        //                     quantity: quan,
        //                     product: product);
        //               },
        //             ),
        //             Container(
        //               color: Colors.white,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     ListTile(
        //                       leading:
        //                       Text("Total:", style: headingStyle),
        //                       trailing: Text("\$${snapshot.data.total}",
        //                           style: headingStyle),
        //                     ),
        //                     DefaultButton(
        //                       text: isloading
        //                           ? "Loading..."
        //                           : "Place order",
        //                       press: isloading
        //                           ? null
        //                           : () async {
        //                         try {
        //                           print(
        //                               "hee ${snapshot.data.products}");
        //                           if (snapshot.data != null &&
        //                               snapshot.data.products !=
        //                                   null) {
        //                             setState(() {
        //                               isloading = true;
        //                             });
        //
        //                             await Future.delayed(
        //                                 Duration(seconds: 4));
        //
        //                             var t = snapshot.data.products
        //                                 .map((prod) {
        //                               // print("prod ${prod['product_id'].id}");
        //                               prod['vendor_id'] =
        //                                   prod['product'].vendor_id;
        //
        //                               prod['product_id'] =
        //                                   prod['product'].id;
        //                               prod['product'] =
        //                                   ProductModel().toMap(
        //                                       prod['product']);
        //                               return prod;
        //                             }).toList();
        //
        //                             //  snapShotProducts=snapShotProducts as List;
        //                             //  var t=snapShotProducts.map((prod){
        //                             //    return ProductModel().toMap(prod['product']);
        //                             //  }).toList();
        //                             // snapshot.data.products['product']=t;
        //                             // print( ProductModel().toMap( snapShotProducts[0]['product']));
        //                             // snapShotProducts.map((s)=> ProductModel().toMap( s['product'])).toList();
        //                             // var prods=snapshot.data.products.map((prod)=> ProductModel().toMap(prod['product'])).toList();
        //                             // print("prods $snapShotProducts");
        //                             var res =
        //                             await CheckoutService()
        //                                 .placeOrder(
        //                                 t,
        //                                 snapshot
        //                                     .data.total);
        //
        //                             buildDialog();
        //                             await Future.delayed(
        //                                 const Duration(seconds: 2));
        //                             Navigator.pushReplacement(
        //                                 context,
        //                                 MaterialPageRoute(
        //                                     builder: (context) =>
        //                                         MainHomeScreen()));
        //                           }
        //                         } catch (Err) {
        //                           SnackBarService().showSnackBar(
        //                               context, Err.toString());
        //                         } finally {
        //                           setState(() {
        //                             isloading = false;
        //                           });
        //                         }
        //                       },
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             )
        //             // const Padding(
        //             //   padding: EdgeInsets.all(8.0),
        //             //   child: DefaultButton(
        //             //     text: "Place order",
        //             //   ),
        //             // )
        //           ],
        //         );
        //       }
        //     })
        );
  }
Future placeOrder() async {
    var pr=Provider.of<CheckoutProvider>(context,listen: false);
  if (pr.checkoutData != null &&
      pr.checkoutData.products != null) {
    setState(() {
      isloading = true;
    });

    await Future.delayed(
        const Duration(seconds: 4));

    var t =
    pr.checkoutData.products.map((prod) {
      // print("prod ${prod['product_id'].id}");
      prod['vendor_id'] = prod['product'].vendor_id;

      prod['product_id'] = prod['product'].id;
      prod['product'] =
          ProductModel().toMap(prod['product']);
      return prod;
    }).toList();

    //  snapShotProducts=snapShotProducts as List;
    //  var t=snapShotProducts.map((prod){
    //    return ProductModel().toMap(prod['product']);
    //  }).toList();
    // snapshot.data.products['product']=t;
    // print( ProductModel().toMap( snapShotProducts[0]['product']));
    // snapShotProducts.map((s)=> ProductModel().toMap( s['product'])).toList();
    // var prods=snapshot.data.products.map((prod)=> ProductModel().toMap(prod['product'])).toList();
    // print("prods $snapShotProducts");
    var res = await CheckoutService()
        .placeOrder(t, pr.checkoutData.total,pr.paymentType);

    buildDialog();
    await Future.delayed(
        const Duration(seconds: 2));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainHomeScreen()));
  }
}
  buildDialog() {
    AlertDialog alert = const AlertDialog(
      title: Text("Order done"),
      content: Text("✅ Your order has been successfully placed"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

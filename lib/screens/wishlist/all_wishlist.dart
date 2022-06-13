import 'package:flutter/material.dart';
import 'package:shop_app/components/checkout_view_product.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/services/cart_service.dart';

import '../../components/botom_navigation_bar.dart';
import '../../enums.dart';
import '../../services/snackbar_service.dart';

class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.wishlist,
        ),
        appBar: buildSimpleAppBar(context, "My Wishlist", searchbar: false),
        body: FutureBuilder(
            future: CartService().getWishlist(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              }
              return snapshot.data.length < 1
                  ? Center(
                      child: const Text('No products here'),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var snapShotProducts = snapshot.data;
                        if (snapShotProducts[index]['product'] == null)
                          return const Text('');
                        return CheckoutViewProduct(
                            ondelete: () async {
                              try {
                                var res = await CartService().deleteWishlist(
                                    snapShotProducts[index]['id']);
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
                            product: snapShotProducts[index]['product']);
                      },
                    );
            }));
  }
}

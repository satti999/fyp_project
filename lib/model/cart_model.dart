import 'package:shop_app/model/cart_view_item_model.dart';

class CartModel {
  num totalprice;
  List<CartViewItemModel> cartproducts;

  CartModel({this.totalprice, this.cartproducts});

  factory CartModel.fromMap(data) {
    var p = data['cart_items'] as List;
    return CartModel(
        totalprice: data['total'],
        cartproducts: p
            .map((cartItemData) => CartViewItemModel.fromMap(cartItemData))
            .toList());
  }
}

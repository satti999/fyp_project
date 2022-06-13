import 'package:shop_app/model/product_model.dart';

class CheckoutModel {
  num total;
  List products;

  CheckoutModel({this.total, this.products});

  factory CheckoutModel.fromMap(data) {
    var cartItems = data['cart_items'] as List;

    return CheckoutModel(
        total: data['total'],
        products: cartItems
            .map((item) => {
                  "id": item['id'],
                  "quantity": item['quantity'],
                  "size_id": item['size_id'],
                  "product": ProductModel.fromMap(item['product'])
                })
            .toList());
  }
}

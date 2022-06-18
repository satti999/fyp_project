import 'package:intl/intl.dart';
import 'package:shop_app/model/product_model.dart';

class OrderModel {
  // "id": 49,
  // "product_id": 1,
  // "client_id": 18,
  // "email": "ksa@gmail.com",
  // "name": "ksa@gmail.com",
  // "address": "VIII civic civicnfnfnrnt",
  // "city": "1",
  // "contact": "03323537811",
  // "state": "1",
  // "add_contact": null,
  // "total_amount": 10,
  // "discount": 0,
  // "amount": 10,
  // "payment_type": "COD",
  // "created_at": "2022-06-13T08:58:40.000000Z",
  // "updated_at": "2022-06-13T08:58:40.000000Z",
  int id;
  num total_amount;
  String payment_type;
  String status;
  String date;
  List<OrderedProduct> products;

  OrderModel(
      {this.id,
      this.total_amount,
      this.payment_type,
      this.products,
      this.date,
      this.status});

  factory OrderModel.fromMap(data) {
    var products = data['product'] as List;
    var order_p = data['order_product'] as List;
    List<OrderedProduct> orderPrds = [];
    for (var i = 0; i < products.length; i++) {
      orderPrds.add(OrderedProduct(
          product: ProductModel.fromMap(products[i]),
          quantity: order_p[i]['quantity']));
    }
    return OrderModel(
        id: data['id'],
        status: data['order_product'][0]['order_status'],
        date:
            DateFormat('MM/dd/yyyy').format(DateTime.parse(data['created_at'])),
        products: orderPrds,
        total_amount: data['total_amount']);
  }
// OrderModel.fromMap(data)
//     : id = data['id'],
//       status = data['order_product'][0]['order_status'],
//       products = data['product'].map((e) => ProductModel.fromMap(e)).toList(),
//       total_amount = data['total_amount'];
}

class OrderedProduct {
  ProductModel product;
  int quantity;

  OrderedProduct({this.product, this.quantity});
}

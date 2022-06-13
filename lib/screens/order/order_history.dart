import 'package:flutter/material.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/services/order_service.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: OrderService().getOrderHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          }

          return snapshot.data.length>0 ? Text('orders'): Text("No records found");
        },
      ),
    );
  }
}

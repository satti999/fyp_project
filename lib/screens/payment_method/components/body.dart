import 'package:flutter/material.dart';
import 'package:shop_app/screens/payment_method/components/payment_btn.dart';
import 'package:shop_app/screens/payment_method/components/table.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(

        child: Column(

          children: [
            Cart_Detail(),
            SizedBox(height: 15),
            PaymentButton()
          ],
        ),


      ),


    );
  }
}

import 'package:flutter/material.dart';
class PaymentButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 120,
        height: 40,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          color: Color(0xFFFF7643),
          onPressed: () {},
          child: Text(
            "Checkout".toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

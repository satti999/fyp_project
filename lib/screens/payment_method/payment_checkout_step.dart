import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/checkout_provider.dart';

class PaymentCheckoutStep extends StatefulWidget {
  const PaymentCheckoutStep({Key key}) : super(key: key);

  @override
  State<PaymentCheckoutStep> createState() => _PaymentCheckoutStepState();
}


class _PaymentCheckoutStepState extends State<PaymentCheckoutStep> {
  @override
  Widget build(BuildContext context) {
    var prv=Provider.of<CheckoutProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.delivery_dining),
                SizedBox(width: 10),
                Text("Cash on delivery "),
              ],
            ),
            leading: Radio<paymentTypeEnum>(
              value: paymentTypeEnum.COD,
              groupValue: prv.paymentType,
              onChanged: (paymentTypeEnum value) {
                setState(() {
                  prv.setpaymentType(value);
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.credit_card),
                SizedBox(width: 10),
                Text("Credit/Debit Card"),
              ],
            ),
            leading: Radio<paymentTypeEnum>(
              value: paymentTypeEnum.Stripe,
              groupValue: prv.paymentType,
              onChanged: (paymentTypeEnum value) {
                setState(() {
                  prv.setpaymentType(value);
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.countertops_rounded),
                SizedBox(width: 10),
                Text("Cash on counter "),
              ],
            ),
            leading: Radio<paymentTypeEnum>(
              value: paymentTypeEnum.COC,
              groupValue: prv.paymentType,
              onChanged: (paymentTypeEnum value) {
                setState(() {
                  prv.setpaymentType(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/model/checkout_model.dart';
import 'package:shop_app/services/api_service.dart';

class CheckoutService {
  final dio = createDio();

  getCheckout() async {
    try {
      var response = await dio.get('view-checkout');
      debugPrint(response.data.toString(), wrapWidth: 3000);
      return CheckoutModel.fromMap(response.data);
    } catch (Er) {
      print(Er);
      throw Er;
    }
  }

  placeOrder(cartItems, totalprice, paymentType) async {
    try {
      String endPoint='payment-type';
      if (paymentType == paymentTypeEnum.COD) {
        paymentType = 'COD';
      }
      else if(paymentType==paymentTypeEnum.COC){
        paymentType = 'COC';

      }
      else if (paymentType == paymentTypeEnum.Stripe) {
          paymentType = 'Stripe';
          endPoint='stripe-pay';
        }

      var d = {
        "total_amount": totalprice,
        "payment_type": paymentType,
        "data": {"carts": cartItems}
      };
      debugPrint("My fav ${d.toString()}", wrapWidth: 3000);

      var response = await dio.post(endPoint, data: d);
      print("response.data ${response.data}");
      return response.data;
      // return CheckoutModel.fromMap(response.data);
    } catch (Er) {
      print("ERROR $Er");
      throw Er;
    }
  }
}

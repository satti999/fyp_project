import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/checkout_model.dart';
import 'package:shop_app/services/api_service.dart';

class CheckoutService{
  final dio=createDio();
  

  getCheckout() async {
    try{
      var response=await dio.get('view-checkout');
      debugPrint(response.data.toString(),wrapWidth: 3000);
      return CheckoutModel.fromMap(response.data);
    }
    catch(Er){
      print(Er);
      throw Er;
    }

  }
  placeOrder(cartItems,totalprice) async {

    try{
      var d={
        "total_amount":totalprice,
        "payment_type":"COD",
        "data":{
          "carts":cartItems
        }
      };
      debugPrint("My fav ${d.toString()}",wrapWidth: 3000);

      var response=await dio.post('payment-type',data: d);
      return response.data['message'];
      // return CheckoutModel.fromMap(response.data);
    }
    catch(Er){
      print(Er);
      throw Er;
    }


  }
}
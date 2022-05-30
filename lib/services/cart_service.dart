import 'package:shop_app/model/cart_model.dart';
import 'package:shop_app/model/cart_view_item_model.dart';

import 'api_service.dart';

class CartService{
  final dio = createDio();

  Future<CartModel> getCartProducts()async{
    try{

      var response = await dio.get('view-cart');
      print (response.data);
      return CartModel.fromMap(response.data);
      // var resp=response.data['cart_items'] as List;
      // List<CartViewItemModel> cartItems= resp.map((cartItemData) => CartViewItemModel.fromMap(cartItemData)).toList();
      // return cartItems;
    }
    catch(er){
      print("cart service $er");
      throw er;
    }
  }

  updateCartProduct(cart)async{
    try{
      print(cart);
      var response = await dio.put('update-cart',data: cart);
      return response.data['message'];
    }
    catch(er){
      print("cart update $er");
      throw er;
    }
  }

  deleteCartProduct(cartid)async{
    try{
      var response = await dio.delete('delete-cart',data: {"cart_id":cartid});
      return response.data['message'];
    }
    catch(er){
      print("cart delete $er");
      throw er;
    }
  }

  addToCart(cart)async{
    try{

      var response = await dio.post('add-to-cart',data: cart);
      return response.data['message'];
    }
    catch(er){
      print("cart service $er");
      throw er;
    }


  }
}
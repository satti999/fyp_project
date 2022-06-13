import 'package:shop_app/model/cart_model.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/api_service.dart';
import 'package:shop_app/services/cart_service.dart';

class ProductService {
  var dio = createDio();

  fetchProductUsingId(String id) async {
    print("HEHE ${id}");
    try {
      var response =
          await dio.get("product-details/?product_id=${id.toString()}");
      var res = response.data['details'] as List;
      return ProductModel.fromMap(res[0]);
    } catch (er) {
      throw er;
    }
  }

  CheckIfProdExistInCart(product_id) async {
    try {
      //fetch cart
      CartModel cartprods = await CartService().getCartProducts();
      //check if this product id exists
      var r = cartprods.cartproducts.firstWhere(
          (element) => element.product_id == product_id,
          orElse: () => null);
      return r ?? 0;
      //display discard
      //delete using cart_id
    } catch (er) {
      throw er;
    }
  }

  CheckIfProdExistInWishlist(product_id) async {
    try {
      //fetch cart
      var wishlistprods = await CartService().getWishlist();
      //check if this product id exists
      var r = wishlistprods.firstWhere(
          (element) =>
              element['product'] != null && element['product'].id == product_id,
          orElse: () => null);
      print("HELO $r");
      return r ?? 0;
      //display discard
      //delete using cart_id
    } catch (er) {
      throw er;
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      var response = await dio.get("products");
      var res = response.data['data'] as List;
      print(res);
      return res.map((prod) => ProductModel.fromMap(prod)).toList();

      // return ProductModel.fromMap(res[0]);
    } catch (er) {
      throw er;
    }
  }

  getRecentProducts() async {
    try {
      var response = await dio.get("recent-products");
      var res = response.data['data'] as List;
      return res.map((prod) => ProductModel.fromMap(prod)).toList();

      // return ProductModel.fromMap(res[0]);
    } catch (er) {
      throw er;
    }
  }

  getDiscountedProducts() async {
    try {
      var response = await dio.get("discounted-products");
      var res = response.data['data'] as List;
      print(res);
      return res.map((prod) => ProductModel.fromMap(prod)).toList();

      // return ProductModel.fromMap(res[0]);
    } catch (er) {
      throw er;
    }
  }
}

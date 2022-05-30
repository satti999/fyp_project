import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/api_service.dart';

class ProductService{
var dio=createDio();

  fetchProductUsingId(String id)async{
    print("HEHE ${id}");
    try{
      var response=await  dio.get("product-details/?product_id=${id.toString()}");
      var res = response.data['details'] as List;
      return ProductModel.fromMap(res[0]);
    }
    catch(er){
      throw er;
    }
  }
  Future<List<ProductModel>> getAllProducts()async{
    try{
      var response=await  dio.get("products");
      var res = response.data['data'] as List;
      print(res);
      return res.map((prod) => ProductModel.fromMap(prod)).toList();

      // return ProductModel.fromMap(res[0]);
    }
    catch(er){
      throw er;
    }
  }

getRecentProducts()async{
  try{
    var response=await  dio.get("recent-products");
    var res = response.data['data'] as List;
    return res.map((prod) => ProductModel.fromMap(prod)).toList();

    // return ProductModel.fromMap(res[0]);
  }
  catch(er){
    throw er;
  }
}
}
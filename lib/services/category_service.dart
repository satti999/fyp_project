import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/model/product_model.dart';

import 'api_service.dart';

class CategoryService {
  final dio = createDio();

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      // return await Future.value(48);
      var response = await dio.get('category');
      var res = response.data['data'] as List;
      // res.map((category){
      //   print(category);
      //
      // }).toList();
      // return Category.fromMap(res[0]);

      List<CategoryModel> categories =
          res.map((category) => CategoryModel.fromMap(category)).toList();
      // List<Category> categories = [];
      // res.forEach((cat) => categories.add(Category.fromMap(cat)));
      return categories;
      // return Category.fromMap(response.data['data']);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  getSubcategoryUsingParentId(int parentId) async {
    try {
      // return await Future.value(48);
      var response = await dio.get('subcategory/?parentcat=${parentId}');
      var res = response.data;

      // res.map((category){
      //   print(category);
      //
      // }).toList();
      // return Category.fromMap(res[0]);
      if(res['message']!=null && res['message']=='No Sub Categories Found') {
        return [];
      }

      res=res['data'] as List;
      List<dynamic> categories =
      res.map((category) => CategoryModel.fromMap(category)).toList();

      return categories;

    } catch (err) {
      print("err $err");
      throw err;
    }
  }

  getCategoryProducts(int categoryId) async {
    try {
      // return await Future.value(48);
      var response = await dio.get('category?categoryId=${categoryId}');
      var res = response.data['data'] as List;
      // res.map((category){
      //   print(category);
      //
      // }).toList();
      // return Category.fromMap(res[0]);
      List<ProductModel> products =
          res.map((product) => ProductModel.fromMap(product)).toList();

      return products;
      // List<Category> categories = [];
      // res.forEach((cat) => categories.add(Category.fromMap(cat)));
      // return categories;
      // return Category.fromMap(response.data['data']);
    } catch (err) {
      print(err);
      throw err;
    }
  }
}

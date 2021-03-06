import 'package:shop_app/model/order_model.dart';
import 'package:shop_app/services/api_service.dart';

class OrderService {
  final dio = createDio();

  getOrderHistory() async {
    try {
      var response = await dio.get("order-history");
      print(response.data);
      var result = response.data;
      if (result['message'] != null &&
          result['message'] == 'No Records Found.') {
        return [];
      }
      var r=response.data['orderhistory'] as List;
      return r.map((e) => OrderModel.fromMap(e)).toList();
      // return ProfileModel.fromMap(response.data['data']);
    } catch (er) {
      print("order service ${er.response}");
      throw er;
    }
  }
}

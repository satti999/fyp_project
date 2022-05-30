import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/services/api_service.dart';

class ProfileService{
  final dio=createDio();
  getUserProfile() async {
    try {
      var response= await dio.get("profile");
      return ProfileModel.fromMap(response.data['data']);
    }
    catch(er){
      print("profile service $er");
      throw er;
    }
  }
  
}
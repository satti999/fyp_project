import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/services/api_service.dart';

class ProfileService {
  final dio = createDio();

  getUserProfile() async {
    try {
      var response = await dio.get("profile");
      return ProfileModel.fromMap(response.data['data']);
    } catch (er) {
      print("profile service $er");
      throw er;
    }
  }

  updateProfile(name, address, email, country, state, city) async {
    try {
      var d = {
        "name": name,
        "address": address,
        "email": email,
        "contact":"03323537811",
        "country": country,
        "state": state,
        "city": city,
        "zip_code": "46400",
        "dob": "2022-10-12",
        "photo": null,
        "social_id": null,
      };
      var response = await dio.put("update-profile", data: d);
      return response.data['data'];
    } catch (er) {
      print("profile update service $er");
      throw er;
    }
  }
}

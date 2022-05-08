import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/services/api_service.dart';


class AuthService {
  final storage = const FlutterSecureStorage();
  final dio = createDio();

  // {
  // // "name":"test",
  // // "email":"test@gmail.com",
  // // "password":"test123",
  // // "contact":"9869392522",
  // // "address":"dhjdjdhjhd"
  // }
  registerUser(String name, String email, String phone, String password) async {
    try {
      var response = await dio.post("auth-register", data: {
        "name": name,
        "contact": phone,
        "password": password,
        "email": email
      });

      return response.data;

      // print("Register ${response.data}");

    } catch (error) {
      print(error);

      var err;
      if (error is DioError) {
        if (error.response.statusCode == 500) {
          err = "User Already Exists";
        } else {
          err = error.response.statusMessage;
        }
      } else {
        err = error;
      }
      throw err;
    }
  }

  userProfile() async {}

  setUserTokenToStorage(value) async {
    await storage.write(key: 'userToken', value: value);
  }

  removeUserTokenFromStorage() async {
    await storage.delete(key: 'userToken');
  }

  getUserTokenFromStorage() async {
    return await storage.read(key: 'userToken');
  }

  loginUser(String phone, String password) async {
    try {
      var response = await dio
          .post("auth-login", data: {"contact": phone, "password": password});
      print("Login ${response.data}");

      setUserTokenToStorage(response.data['token']);
      return response.data;
    } catch (error) {
      print(error);

      var err;
      if (error is DioError) {
        if (error.response.statusCode == 500) {
          err = "Invalid Credentials";
        } else {
          err = error.response.statusMessage;
        }
      } else {
        err = error;
      }
      throw err;
    }
  }

  logoutUser() async {
    try {
      var response = await dio.post("logout");
      print("Logout ${response.data}");
      await removeUserTokenFromStorage();
      return response;
    } catch (error) {
      print(error.response.data);
      throw error;
    }
  }
}

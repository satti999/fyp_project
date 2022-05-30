import 'package:flutter/foundation.dart';

import 'package:shop_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  bool _loading=false;
bool _isLoggedIn=false;

  AuthProvider(){
    getUser();
  }

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();

  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final AuthService _authService = AuthService();

  register(String name, String email, String phone, String password) async {
    try {
     await  _authService.registerUser(name, email, phone, password);

    }
    catch(err){
     throw err;
    }
  }
  login(String phone, String password) async {
    try {
      await  _authService.loginUser(phone, password);
    }
    catch(err){
      print(err);
      throw err;
    }
  }
  logout() async {
    try {
      loading=true;
      await  _authService.logoutUser();
      isLoggedIn=false;
    }
    catch(err){
      rethrow;
    }
    finally{
    loading=false;

    }
  }

  getUser() async {
    loading=true;
    var token=await _authService.getUserTokenFromStorage();
    print(token);
    isLoggedIn = token!=null;
    loading=false;
  }



}
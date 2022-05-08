import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';




Dio createDio(){
  var options = BaseOptions(
    baseUrl: APIHOST,
  );
  Dio dio = Dio(options);
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options,handler) async {
    final token=await getToken();
    print("token $token");
    if (token!=null) {
      options.headers['authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }));
  return dio;
}

getToken() async {
  return await FlutterSecureStorage().read(key: 'userToken');
}

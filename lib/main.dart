import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/wrapper.dart';
import 'package:shop_app/constants.dart';

import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/category_service.dart';
import 'package:shop_app/services/product_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        FutureProvider(
            create: (_) => CategoryService().getAllCategories(),

            catchError: (context, error) {
              print("Future Category Provider in Main File ---> ${error}");
              return null;
            }),
        FutureProvider(
            create: (_) => ProductService().getAllProducts(),
            catchError: (context, error) {
              print("Future Product Provider in Main File ---> ${error}");
              return null;
            }),
        // FutureProvider(create: (_)=> CartService().getCartProducts(),catchError: (context,error){
        //   print(error);
        // })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        ),
        home: Wrapper(),
      ),
    );
  }
}

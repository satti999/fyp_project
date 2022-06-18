import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/wrapper.dart';
import 'package:shop_app/constants.dart';

import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/checkout_provider.dart';
import 'package:shop_app/services/category_service.dart';
import 'package:shop_app/services/product_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51Kot6tSJJEGLybA3qT7W2O54u5xVsq56zwUgcO3igrV9apf56l3111t9E8L9k32MTr354pONkCbdDX1ekMvdvHrH00HeaBJwRW';
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();

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
        ChangeNotifierProvider(create: (_) => CheckoutProvider())
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

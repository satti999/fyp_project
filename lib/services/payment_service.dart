import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/services/snackbar_service.dart';

class PaymentService {
  Map<String, dynamic> paymentIntentData;
  final stripeSecretKey =
      'sk_test_51Kot6tSJJEGLybA3ZBLbxnD8nr3k9ap4K38GQAScAs7glMK8T99xiKti0xTdxzT1dVuEXkgXbolCV3Fj6mKfS1cW00zxRj7xlX';

  Future<void> makePayment(
      {String amount, String currency, BuildContext context,name,address,state,country,city}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency,context,name,address,city,state,country);
      print("payment intent $paymentIntentData");
      if(name==null||address==null||state==null||country==null||city==null){
        return SnackBarService().showSnackBar(context, "No customer details provided");

      }
      if (paymentIntentData != null) {

        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          billingDetails: BillingDetails(
            name: name,
            address: Address(
              country: country,
              line1: address,
              state: state,
              city: city
            )
          ),
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData['customer'],
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
        ));
        await displayPaymentSheet(context);
      }
    } catch (e, s) {
      SnackBarService().showSnackBar(context, "exception:$e$s");

      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      SnackBarService().showSnackBar(context, "Payment Successful");
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      SnackBarService().showSnackBar(context, "exception:$e");
      print("exception:$e");
    }
  }

  createcustomer(name,address,city,state,country) async {
    try {
      var data = {
        'name': '$name',
        'address': {
          'line1': '$address',
          'postal_code': '98140',
          'city': '$city',
          'state': '$state',
          'country': '$country',
        }
      };
      Response response = await Dio().post(
        'https://api.stripe.com/v1/customers',
        data: data,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Authorization': 'Bearer $stripeSecretKey', // your secret key
        }),
      );
      print('response user: ${response.data}');
      return response.data;
    } catch (err) {
      print('err creating user: ${err.toString()}');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency,BuildContext context,name,address,city,state,country) async {
    try {
      var customer=await createcustomer(name,address,city,state,country);

      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'description': "Software development services",
        'payment_method_types[]': 'card',
        'customer':customer['id'],
      };
      var response =
          await Dio().post('https://api.stripe.com/v1/payment_intents',
              data: body,
              options: Options(headers: {
                'Authorization': 'Bearer $stripeSecretKey',
                'Content-Type': 'application/x-www-form-urlencoded'
              })
              // headers: {
              //   'Authorization': 'Bearer Your Stripe Secret Key',
              //   'Content-Type': 'application/x-www-form-urlencoded'
              // }

              );
      return response.data;
    } catch (err) {
      SnackBarService().showSnackBar(context, "exception:$err");

      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

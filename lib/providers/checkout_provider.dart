import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/services/checkout_service.dart';
import 'package:shop_app/services/profile_service.dart';

import '../constants.dart';
import '../model/checkout_model.dart';
import '../model/profile_model.dart';
class CheckoutProvider extends ChangeNotifier {


  final _formKey = GlobalKey<FormState>();
  paymentTypeEnum _paymentType = paymentTypeEnum.COD;


  paymentTypeEnum get paymentType => _paymentType;

  setpaymentType(paymentTypeEnum value) {
    _paymentType = value;
    notifyListeners();
  }

  CheckoutModel get checkoutData => _checkoutData;

  set checkoutData(CheckoutModel value) {
    _checkoutData = value;
    notifyListeners();
  }

  CheckoutModel _checkoutData;
  GlobalKey<FormState> get formKey => _formKey;

  final Map _shippingDetails = {};

  get shippingDetails => _shippingDetails;
bool _isloading=false;


  bool get isloading => _isloading;

  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setShippingFields(name, country, city, state, address) {
    _shippingDetails['name'] = name;
    _shippingDetails['country'] = country;
    _shippingDetails['state'] = state;
    _shippingDetails['city'] = city;
    _shippingDetails['address'] = address;
    notifyListeners();
  }

  setShippingField(String key, value) {
    _shippingDetails[key] = value;
    notifyListeners();
  }

  deleteCheckoutProduct() async{

  }
  fetchCheckoutData() async {
    try {

      // isloading=true;
       var res=await CheckoutService().getCheckout();
       // return res;
       checkoutData=res;
       return res;
    } catch (er) {
      print(er);
    }
    // finally{
    //   isloading=false;
    // }
  }

  fetchProfile() async {
    try {
      // isloading=true;
      ProfileModel profile = await ProfileService().getUserProfile();
      Country country=CountryPickerUtils.getCountryByName(profile.country);
      setShippingFields(profile.name, country.isoCode, profile.state,
          profile.city, profile.address);
return profile;
    } catch (er) {
      print("ERROR $er");
    }
  }
}

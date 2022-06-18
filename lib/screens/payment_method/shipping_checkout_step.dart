import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/checkout_provider.dart';

import '../../home_constans.dart';

import '../../size_config.dart';

class ShippingCheckoutStep extends StatefulWidget {
  const ShippingCheckoutStep({Key key}) : super(key: key);

  @override
  State<ShippingCheckoutStep> createState() => ShippingCheckoutStepState();
}

class ShippingCheckoutStepState extends State<ShippingCheckoutStep> {
  bool _isloading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // p.fetchProfile();(
    fetchProfileData();
  }
  fetchProfileData() async {
    var p = Provider.of<CheckoutProvider>(context, listen: false);
    await p.fetchProfile();
    setState(() {
      _isloading=false;
    });
  }

  var nameController = TextEditingController(text: '');

  var emailController = TextEditingController(text: '');

  var countryController = TextEditingController(text: '');

  var stateController = TextEditingController(text: '');

  var cityController = TextEditingController(text: '');

  var addressController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var prv = Provider.of<CheckoutProvider>(context);
    // return Text('${prv.shippingDetails}');
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(
            color: kPrimaryColor,
          ))
        : Form(
            key: prv.formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    prv.setShippingField('name', value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return kNamelNullError;
                    }
                    return null;
                  },
                  initialValue: prv.shippingDetails['name'],
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: outlineInputBorder(),
                    hintText: "Enter your name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                // TextFormField(
                //   controller: emailController,
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return kEmailNullError;
                //     } else if (!emailValidatorRegExp.hasMatch(value)) {
                //       return kInvalidEmailError;
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     labelText: "Email",
                //     border: outlineInputBorder(),
                //     hintText: "Enter your email",
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //   ),
                // ),
                // TextFormField(
                //   onChanged: (value) {
                //     prv.setShippingField('country', value);
                //   },
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return "Please Enter Country";
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     labelText: "Country",
                //     border: outlineInputBorder(),
                //     hintText: "Enter your country",
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: CountryPickerDropdown(
                            isExpanded: true,
                            initialValue: prv.shippingDetails['country'],
                            itemBuilder: _buildDropdownItem,
                            // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                            sortComparator: (Country a, Country b) =>
                                a.isoCode.compareTo(b.isoCode),
                            onValuePicked: (Country country) {
                              prv.setShippingField('country', country.isoCode);
                              print("Khurram here ${country.isoCode}");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  initialValue: prv.shippingDetails['state'],
                  onChanged: (value) {
                    prv.setShippingField('state', value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter State";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "State",
                    border: outlineInputBorder(),
                    hintText: "Enter your state",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  initialValue: prv.shippingDetails['city'],
                  onChanged: (value) {
                    prv.setShippingField('city', value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter City";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    border: outlineInputBorder(),
                    hintText: "Enter your city",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  initialValue: prv.shippingDetails['address'],
                  onChanged: (value) {
                    prv.setShippingField('address', value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: outlineInputBorder(),
                    hintText: "Enter your address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
              ],
            ));
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 20.0,
            ),
            Text("${country.isoCode}"),
          ],
        ),
      );
}

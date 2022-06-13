import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/services/profile_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

import '../../home_constans.dart';
import '../../size_config.dart';

class EditProfile extends StatefulWidget {
  ProfileModel userprofile;

  EditProfile({Key key, this.userprofile}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  bool isloading = false;
  var nameController = TextEditingController(text: '');

  var emailController = TextEditingController(text: '');

  var countryController = TextEditingController(text: '');

  var stateController = TextEditingController(text: '');

  var cityController = TextEditingController(text: '');

  var addressController = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.userprofile.name;
    emailController.text = widget.userprofile.email;
    countryController.text = widget.userprofile.country;
    stateController.text = widget.userprofile.state;
    cityController.text = widget.userprofile.country;
    addressController.text = widget.userprofile.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSimpleAppBar(context, "Edit Profile", searchbar: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: outlineInputBorder(),
                    hintText: "Enter your name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return kEmailNullError;
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                      return kInvalidEmailError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: outlineInputBorder(),
                    hintText: "Enter your email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  controller: countryController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Country";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Country",
                    border: outlineInputBorder(),
                    hintText: "Enter your country",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                TextFormField(
                  controller: stateController,
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
                  controller: cityController,
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
                  controller: addressController,
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultButton(
          text: isloading ? "Loading..." : "Update",
          press: isloading
              ? null
              : () async {
                  try {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isloading = true;
                      });
                      await ProfileService().updateProfile(
                          nameController.text,
                          addressController.text,
                          emailController.text,
                          countryController.text,
                          stateController.text,
                          cityController.text);
                      SnackBarService()
                          .showSnackBar(context, "Updated Successfully");
                    }
                  } catch (er) {
                    SnackBarService().showSnackBar(context, "$er");
                  } finally {
                    setState(() {
                      isloading = false;
                    });
                  }
                },
        ),
      ),
    );
  }
}

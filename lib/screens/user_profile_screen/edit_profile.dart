import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/services/profile_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

import '../../home_constans.dart';
import '../../size_config.dart';

class EditProfile extends StatelessWidget {
  ProfileModel userprofile;
  var nameController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var countryController = TextEditingController(text: '');
  var stateController = TextEditingController(text: '');
  var cityController = TextEditingController(text: '');
  var addressController = TextEditingController(text: '');

  EditProfile({Key key, this.userprofile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nameController.text = userprofile.name;
    emailController.text = userprofile.email;
    countryController.text = userprofile.country;
    stateController.text = userprofile.state;
    cityController.text = userprofile.country;
    addressController.text = userprofile.address;
    return Scaffold(
      appBar: buildSimpleAppBar(context, "Edit Profile", searchbar: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultButton(
          text: "Update",
          press: () async {
            try {
              await ProfileService().updateProfile(
                  nameController.text,
                  addressController.text,
                  emailController.text,
                  countryController.text,
                  stateController.text,
                  cityController.text);
              SnackBarService().showSnackBar(context, "Updated Successfully");
            } catch (er) {
              SnackBarService().showSnackBar(context, "$er");
            }
          },
        ),
      ),
    );
  }
}

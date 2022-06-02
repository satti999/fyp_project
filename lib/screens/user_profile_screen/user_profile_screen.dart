import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/wrapper.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/order/order_history.dart';
import 'package:shop_app/screens/user_profile_screen/edit_profile.dart';
import 'package:shop_app/screens/wishlist/all_wishlist.dart';
import 'package:shop_app/services/profile_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isloading = false;
  ProfileModel _userprofile;

  fetchProfile() async {
    try {
      setState(() {
        _isloading=true;
      });
      ProfileModel res = await ProfileService().getUserProfile();
      setState(() {
        _userprofile = res;
      });
    } catch (er) {
      SnackBarService().showSnackBar(context, "$er");
    }
    finally{
      setState(() {
        _isloading=false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();
  }

  var menuItems = [
    {
      "text": "Edit Profile",
      "icon": Icons.account_box,
    },
    {"text": "My Orders", "icon": Icons.history},
    {"text": "My Wishlist", "icon": Icons.favorite},
  ];

  getUserP(){
    return _userprofile;
  }
  @override
  Widget build(BuildContext context) {
    var routes=[EditProfile(userprofile: _userprofile,),const OrderHistory(),const WishList()];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isloading
            ? const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    // child: FutureBuilder(
                    //   future: ProfileService().getUserProfile(),
                    //   builder: (context, snapshot) {
                    //     if (!snapshot.hasData) {
                    //       return const Center(
                    //           child: CircularProgressIndicator(color: kPrimaryColor));
                    //     }
                    //     ProfileModel userprofile = snapshot.data;
                    //     return Text("Hi ${userprofile.name}", style: headingStyle);
                    //   },
                    // ),
                  ),
                  Text("Hi ${_userprofile.name}", style: headingStyle),
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) {
                      if (index < menuItems.length) return Divider();
                    },
                    itemCount: menuItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return menuItem(
                          menuItems[index]['text'], menuItems[index]['icon'],
                          onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    routes[index]));
                      });
                    },
                  )),
                  Consumer<AuthProvider>(builder:
                      (BuildContext context, AuthProvider auth, Widget child) {
                    return DefaultButton(
                      text: auth.loading ? "Loading..." : "Logout",
                      press: auth.loading
                          ? null
                          : () async {
                              try {
                                await auth.logout();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()));
                              } catch (err) {
                                print(err);
                              }
                            },
                    );
                  })
                ],
              ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }

  Widget menuItem(String text, IconData icon, {Function onpressed}) {
    return ListTile(title: Text(text), leading: Icon(icon), onTap: onpressed);
  }
}

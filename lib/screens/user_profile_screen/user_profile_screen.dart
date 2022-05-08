import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/botom_navigation_bar.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/wrapper.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
}

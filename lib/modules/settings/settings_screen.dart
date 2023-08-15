import 'package:ecommerce_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:ecommerce_app/modules/previous_orders/preivious_orders_screen.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  SettingsScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: pageStorageKey,
      physics: BouncingScrollPhysics(),
      children: [
        Divider(
          height: 0.0,
        ),
        MaterialButton(
          onPressed: () {
            navigateTo(context, EditProfileScreen());
          },
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontFamily: "QuickSand",
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Divider(
          height: 0.0,
        ),
        MaterialButton(
          onPressed: () {
            navigateTo(context, OrdersScreen());
          },
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Previous orders",
              style: TextStyle(
                fontFamily: "QuickSand",
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Divider(
          height: 0.0,
        ),
      ],
    );
  }
}

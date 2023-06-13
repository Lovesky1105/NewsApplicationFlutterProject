import 'package:flutter/material.dart';

import '../components/my_list_tile.dart';


class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onAdminTap;
  final void Function()? onNBATap;

  const MyDrawer({super.key,
    required this.onProfileTap,
    required this.onSignOut,
    required this.onAdminTap,
    required this.onNBATap
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //header
          const DrawerHeader(child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          ),
          ),

          //home lust tile
          MyListTile(
              icon: Icons.home,
              text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),


          //profile list tile
          MyListTile(
            icon: Icons.person,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),


          MyListTile(
            icon: Icons.admin_panel_settings_rounded,
            text: 'A D M I N',
            onTap: onAdminTap,
          ),

          MyListTile(
            icon: Icons.sports,
            text: 'N B A ',
            onTap: onNBATap,
          ),


          //logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}

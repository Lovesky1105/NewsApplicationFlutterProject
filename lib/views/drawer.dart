import 'package:flutter/material.dart';

import '../components/my_list_tile.dart';


class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onAdminTap;
  final void Function()? onGetNewsTap;
  final void Function()? onPostNewsTap;
  final void Function()? onEditDeleteTap;
  final void Function()? onHomePageTap;

  const MyDrawer({
    Key? key,
    required this.onProfileTap,
    required this.onAdminTap,
    required this.onGetNewsTap,
    required this.onPostNewsTap,
    required this.onEditDeleteTap,
    required this.onHomePageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // header
            const DrawerHeader(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              ),
            ),

            // home list tile
            MyListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: onHomePageTap,
            ),

            // profile list tile
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
              icon: Icons.feed,
              text: 'N E W S ',
              onTap: onGetNewsTap,
            ),

            MyListTile(
              icon: Icons.add,
              text: 'A D D  P O S T ',
              onTap: onPostNewsTap,
            ),

            MyListTile(
              icon: Icons.edit,
              text: 'E D I T / D E L E T E  P O S T ',
              onTap: onEditDeleteTap,
            ),

          ],
        ),
      ),
    );
  }
}


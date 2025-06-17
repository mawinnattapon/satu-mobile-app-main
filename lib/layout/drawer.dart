import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/models/user/user.profile.model.dart';
import 'package:satu/modules/controller/app.ctrl.dart';
import 'package:satu/modules/controller/user.ctrl.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppDrawer({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GetBuilder<UserController>(builder: (ctrl) {
            var profile = ctrl.userModel ?? Profile();
            return Stack(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(profile.fullName ?? "-", style: const TextStyle(fontSize: 18)),
                  accountEmail: Text(profile.email ?? "-"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColor.light,
                    child: Text(
                      profile.iconName,
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () => scaffoldKey.currentState!.closeEndDrawer(),
                        icon: const Icon(Icons.close, color: AppColor.black, size: 32),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          ListTile(
            onTap: () {
              scaffoldKey.currentState!.closeEndDrawer();
              Get.toNamed(AppRoutes.changePwd);
            },
            title: const Text(
              'Change Password',
              textAlign: TextAlign.center,
            ),
          ),
          AppController.instance.config.remove
              ? Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1),
                    ),
                    ListTile(
                      onTap: () {
                        scaffoldKey.currentState!.closeEndDrawer();
                        UserController.instance.removeUser();
                      },
                      title: const Text(
                        'Remove Account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          ),
          ListTile(
            onTap: () {
              scaffoldKey.currentState!.closeEndDrawer();
              Get.toNamed(AppRoutes.privacy);
            },
            title: const Text(
              'Privacy & Policy',
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          ),
          ListTile(
            onTap: () {
              scaffoldKey.currentState!.closeEndDrawer();
              UserController.instance.fetchSignout();
            },
            title: const Text(
              'Logout',
              style: TextStyle(color: AppColor.warning),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

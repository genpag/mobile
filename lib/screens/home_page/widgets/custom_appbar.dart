import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/services/theme_services.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/profile.png",
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
        leading: IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
            },
            icon: Icon(
              Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              size: 20,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

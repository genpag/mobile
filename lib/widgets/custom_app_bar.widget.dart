import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({@required this.title});

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              height: 59,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

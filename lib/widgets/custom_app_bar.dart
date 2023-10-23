import 'package:flutter/material.dart';

import '../style/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: AppColor.blue),
      ),
      actions: actions,
      backgroundColor: AppColor.navy,
      actionsIconTheme: IconThemeData(color: AppColor.darkPink, size: 28),
      elevation: 10,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

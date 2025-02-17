import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  const CustomAppBar(
      {super.key,
      this.elevation,
      this.bottom,
      this.leading,
      this.centerTitle = true,
      this.height = kToolbarHeight,
      required this.title,
      this.actions});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      //leading: InkWell(onTap: () {}, child: const Icon(Icons.menu)),
      elevation: elevation,
      backgroundColor: AppColors.appColors,
      centerTitle: false,
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          title!,
          textScaleFactor: 1.0,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appTitle;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final void Function(BuildContext)?
      back; // Adjusted type to accept BuildContext

  const CustomAppBar({
    super.key,
    required this.appTitle,
    this.onPressed,
    this.actions,
    this.back,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      actions: actions,
      title: Text(
        appTitle,
        style: const TextStyle(color: YouAppColor.whiteColor, fontSize: 16),
      ),
      leading: GestureDetector(
        onTap: () {
          if (back != null) {
            back!(context); // Call the back function with the context
          } else {
            Navigator.pop(context); // Fallback to Navigator.pop if back is null
          }
        },
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: YouAppColor.whiteColor,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 14, color: YouAppColor.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

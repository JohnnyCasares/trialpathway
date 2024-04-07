import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.actions});
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: const Text('Trial Pathway'),
      centerTitle: true,
      actions: actions,

    );
  }

  @override

  Size get preferredSize => const Size.fromHeight(50);
}

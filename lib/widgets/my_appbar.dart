import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});


  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override

  Size get preferredSize => const Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =getIt<SharedPreferences>().getBool('isDarkMode')?? (Theme.of(context).brightness == Brightness.dark);

    final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.light_mode_outlined);
        }
        return const Icon(Icons.dark_mode_outlined);
      },
    );


    return AppBar(

      title: const Text('Trial Pathway'),
      centerTitle: true,
      actions: [
        toggleThemeButton(isDarkMode, thumbIcon),

      ],

    );
  }

  toggleThemeButton(isDarkMode,thumbIcon){
    return Switch(
      thumbIcon: thumbIcon,
      value: isDarkMode,
      onChanged: (bool value) {
        if (isDarkMode) {
          MyApp.of(context)!.toggleTheme(ThemeMode.light);
        } else {
          MyApp.of(context)!.toggleTheme(ThemeMode.dark);
        }

      },
    );
  }
  
}

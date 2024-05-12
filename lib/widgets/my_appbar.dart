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
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = !(getIt<SharedPreferences>().getBool('isDarkMode') ??
        (Theme.of(context).brightness == Brightness.dark));
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
      title: Text(
        'Trial Pathway',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      centerTitle: true,
      actions: [
        Switch(
          thumbIcon: thumbIcon,
          value: isDarkMode,
          onChanged: (bool value) {
            setState(() {
              isDarkMode = value;
            });

            if (value) {
              MyApp.of(context)!.toggleTheme(ThemeMode.light);
            } else {
              MyApp.of(context)!.toggleTheme(ThemeMode.dark);
            }
          },
        )
      ],
    );
  }
}

// class ThemeProvider extends ChangeNotifier{
//   late bool isDark;
//   ThemeProvider(BuildContext context){
//     _setBool(context);
//   }
//   _setBool(BuildContext context){
//     isDark = getIt<SharedPreferences>().getBool('isDarkMode')?? (Theme.of(context).brightness == Brightness.dark);
//   }
//
//   updateIsDark(bool value){
//     isDark = value;
//     notifyListeners();
//   }
//
// }

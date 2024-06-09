import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el modo actual del tema
    final currentThemeMode = AdaptiveTheme.of(context).mode;
    // Determinar si el modo oscuro está activado
    final isDarkMode = currentThemeMode == AdaptiveThemeMode.dark;

    return AppBar(
      backgroundColor: const Color(0xFF353535),
      title: const Text("CPU INFO", style: TextStyle(color: Colors.white)),
      actions: [
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            if (value) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(color: Colors.black, height: 1.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({super.key});

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text("CPUINFO"),
//     );
//   }
// }

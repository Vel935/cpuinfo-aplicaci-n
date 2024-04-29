import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // Personaliza el AppBar según tus necesidades
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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

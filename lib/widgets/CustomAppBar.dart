import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF353535),
      title: const Text("CPU INFO", style: TextStyle(color: Colors.white)),
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

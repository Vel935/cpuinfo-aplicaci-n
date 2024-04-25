import 'package:cpuinfo_application/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CPU INFO",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("CPU INFO")),
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

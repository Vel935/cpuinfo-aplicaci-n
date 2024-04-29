//hacer una pagina que tenga un letrero en la mitad que diga bienvenido a CPU info y que pase a otra pantalla luego de 5 segundos
import 'dart:async';

import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/pages/homePage/homePage.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPU Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, 'secondPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Color(0xFF4DC9FF), // Add background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(35.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(05.0),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Text(
                  '¡Bienvenido a CPU Info!',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

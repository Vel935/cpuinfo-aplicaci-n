//hacer una pagina que tenga un letrero en la mitad que diga bienvenido a CPU info y que pase a otra pantalla luego de 5 segundos
import 'dart:async';

import 'package:cpuinfo_application/main.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: SplashScreen(),
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
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background.png'),
          fit: BoxFit.cover,
        ),
      ),
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
    );
  }
}

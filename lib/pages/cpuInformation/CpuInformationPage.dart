import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CpuInformationPage extends StatefulWidget {
  const CpuInformationPage({super.key});

  @override
  State<CpuInformationPage> createState() => _CpuInformationPageState();
}

class _CpuInformationPageState extends State<CpuInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la CPU'),
      ),
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción que deseas realizar al presionar el botón
        },
        child: Icon(Icons.add), // Icono del botón flotante
      ),
    );
  }
}

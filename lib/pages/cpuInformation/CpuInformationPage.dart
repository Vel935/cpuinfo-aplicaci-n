import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CpuInformationPage extends StatefulWidget {
  //final String processorId; // Agrega una variable para recibir el parámetro
  const CpuInformationPage({Key? key}) : super(key: key);

  @override
  _CpuInformationPageState createState() => _CpuInformationPageState();
}

class _CpuInformationPageState extends State<CpuInformationPage> {
  @override
  Widget build(BuildContext context) {
    // Obtiene el estado del Provider
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final data = args["data"];
    final comparadorProvider = Provider.of<CpuComparatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(data),
      ),
      body: Placeholder(),
      // Muestra u oculta el botón flotante basado en el estado del Provider
      floatingActionButton: comparadorProvider.comparing
          ? FloatingActionButton(
              onPressed: () {
                // Acción que deseas realizar al presionar el botón
              },
              child: Icon(Icons.add), // Icono del botón flotante
            )
          : null, // Si no estás comparando, no muestra el botón flotante
    );
  }
}

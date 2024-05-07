import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recupera los argumentos
    final Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    // Utiliza los datos pasados como argumentos
    final data = args["data"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
      ),
      body: Center(
        child: Text('Datos recibidos: $data'),
      ),
    );
  }
}

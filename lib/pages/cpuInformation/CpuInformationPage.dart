import 'package:cloud_firestore/cloud_firestore.dart'; // Importar para JsonQueryDocumentSnapshot
import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CpuInformationPage extends StatefulWidget {
  const CpuInformationPage({Key? key}) : super(key: key);

  @override
  _CpuInformationPageState createState() => _CpuInformationPageState();
}

class _CpuInformationPageState extends State<CpuInformationPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final snapshot = args["data"] as DocumentSnapshot; // Cambio aquí
    final data = snapshot.data() as Map<String, dynamic>; // Cambio aquí
    final comparadorProvider = Provider.of<CpuComparatorProvider>(context);
    // final lastButtonPressed = CpuComparatorProvider().lastButtonPressed;
    final lastButtonPressed = Provider.of<CpuComparatorProvider>(context);

    final chica = CpuComparatorProvider().getpalabra;

    return Scaffold(
      appBar: mainAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Información del procesador:'),
            Text('marca: ${data['brand']}'),
            Text('modelo: ${data['model']}'),
            Text('nucleos: ${data['cores']}'),
            Text('frecuencia: ${data['minfreq']}'),
            Text('generacion: ${data['generation']}'),
            Text('famila: ${data['family']}'),
            Text('tipo: ${data['type']}'),
          ],
        ),
      ),
      floatingActionButton: comparadorProvider.comparing
          ? FloatingActionButton(
              onPressed: () {
                String variable = "";
                variable = lastButtonPressed.lastButtonPressed;
                print(
                    'ALL RIGHT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$variable');
                // print(
                //     'ALL RIGHT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$lastButtonPressed');
                // print(
                //     'PALABRAAAAAA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$palabra');

                Provider.of<CpuComparatorProvider>(context, listen: false)
                    .updateState(false);

                if (variable == "right") {
                  print("RIGHTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT $snapshot");
                  Provider.of<CpuComparatorProvider>(context, listen: false)
                      .setData1(snapshot);
                }

                if (variable == "left") {
                  print("LEFTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT $snapshot");
                  Provider.of<CpuComparatorProvider>(context, listen: false)
                      .setData2(snapshot);
                }

                Navigator.pushNamedAndRemoveUntil(
                    context, 'comparatormenu', (route) => false); // Cambio aquí
                // Navigator.popAndPushNamed(context, 'comparatormenu',
                //     arguments: {"data": snapshot}); // Cambio aquí
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart'; // Importar para JsonQueryDocumentSnapshot
import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    Color color() {
      if (data['brand'] == 'INTEL') {
        return Colors.blue;
      } else if (data['brand'] == 'AMD') {
        return Colors.orange;
      } else {
        return Colors.black;
      }
    }

    Color setLetterColor() {
      if (data['brand'] == 'INTEL') {
        return Colors.white;
      } else if (data['brand'] == 'AMD') {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    final chica = CpuComparatorProvider().getpalabra;

    return Scaffold(
      appBar: mainAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: Color.fromRGBO(81, 81, 81, 1)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                fullProcessorName(color, data, setLetterColor),
                Row(
                  children: [
                    mainSpecsBoxes(color, data, "Nucleos",
                        data['cores'].toString(), setLetterColor),
                    mainSpecsBoxes(color, data, "Frecuencia",
                        "${data['maxFreq']} GHz", setLetterColor),
                    mainSpecsBoxes(color, data, "Precio", "\$${data['price']}",
                        setLetterColor)
                  ],
                ),
                const Divider(
                  height: 20, // Altura de la línea
                  thickness: 1, // Grosor de la línea
                  color: Colors.grey,
                  endIndent: 12.0, // Color de la línea
                  indent: 12.0, // Color de la línea
                ),
                specsLine(color, setLetterColor, data, "Frecuencia base",
                    "${data['minfreq']} GHz"),
                specsLine(color, setLetterColor, data, "Marca",
                    data['brand'].toString()),
                specsLine(color, setLetterColor, data, "Modelo",
                    data['model'].toString()),
                specsLine(color, setLetterColor, data, "Generacion",
                    data['generation'].toString()),
                specsLine(color, setLetterColor, data, "Familia",
                    data['family'].toString()),
                specsLine(color, setLetterColor, data, "Tipo",
                    data['type'].toString()),
                specsLine(color, setLetterColor, data, "Socket",
                    data['socket'].toString()),
                specsLine(color, setLetterColor, data, "GPU",
                    data['integratedGpu'].toString()),
                specsLine(color, setLetterColor, data, "Arquitectura",
                    data['architecture'].toString()),
                specsLine(color, setLetterColor, data, "Proceso de Fabricacion",
                    "${data['lithography']} nm"),
                specsLine(
                    color, setLetterColor, data, "TDP", "${data['tdp']}" "W"),
                specsLine(
                    color, setLetterColor, data, "Hilos", "${data['threads']}"),
                specsLine(color, setLetterColor, data, "Version PCIe",
                    "${data['pciExpress']}"),
              ],
            ),
          ),
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

  Row specsLine(Color color(), Color setLetterColor(),
      Map<String, dynamic> data, String textLine, dynamic textData) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                border: Border.all(color: color()),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: color(),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(textLine,
                              style: TextStyle(
                                  color: setLetterColor(),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("$textData",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: setLetterColor()))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Expanded mainSpecsBoxes(
      Color color(),
      Map<String, dynamic> data,
      String superiorText,
      String inferiorText,
      Color Function() setLetterColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: color()),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: color(),
              ),
              child: Text(
                superiorText,
                style: TextStyle(
                    backgroundColor: color(), color: setLetterColor()),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(inferiorText,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: setLetterColor()))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row fullProcessorName(Color Function() color, Map<String, dynamic> data,
      Color Function() setLetterColor) {
    return Row(
      children: [
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color(),
              ),
              child: Text(
                '${data['brand']} ${data['family']} ${data['model']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: setLetterColor(),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      ],
    );
  }
}

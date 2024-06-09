import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ComparatorAddPage extends StatelessWidget {
  const ComparatorAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comparatorProvider = Provider.of<CpuComparatorProvider>(context);
    final data1 = comparatorProvider.data1;
    final data2 = comparatorProvider.data2;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF353535),
        title: const Text("CPU INFO", style: TextStyle(color: Colors.white)),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              if (value) {
                AdaptiveTheme.of(context).setDark();
              } else {
                AdaptiveTheme.of(context).setLight();
              }
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes controlar la acción cuando se presiona el botón de retroceso
            // Por ejemplo, puedes usar Navigator.popAndPushNamed para navegar a una página específica
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: (data1?['brand'] == 'AMD')
                          ? Colors.orange
                          : (data1?['brand'] == 'INTEL')
                              ? Colors.blue
                              : isDarkMode
                                  ? Colors.grey[850]
                                  : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: selectButtonStyle(),
                              onPressed: () {
                                Provider.of<CpuComparatorProvider>(context,
                                        listen: false)
                                    .setLastButtonPressed(
                                        "right"); // Actualizar el último botón presionado

                                Provider.of<CpuComparatorProvider>(context,
                                        listen: false)
                                    .updateState(true);

                                Navigator.pushNamed(
                                    context, 'viewAllProcessors');
                              },
                              child: Text(
                                  data1 != null ? '${data1['fullName']}' : '+',
                                  style: selectTextButtonStyle()),
                            ),
                          ),
                          leftRow("Mod",
                              data1 != null ? '${data1['model']}' : '0.0'),
                          leftRow(
                              "Co", data1 != null ? '${data1['cores']}' : '0'),
                          leftRow("Hil",
                              data1 != null ? '${data1['threads']}' : '0'),
                          leftRow("Frecuenc",
                              data1 != null ? '${data1['maxFreq']}' : '0.0'),
                          leftRow("Frecuenc",
                              data1 != null ? '${data1['minfreq']}' : '0.0'),
                          leftRow(
                              "Proceso de",
                              data1 != null
                                  ? '${data1['lithography']}nm'
                                  : '0nm'),
                          leftRow(
                              "TD", data1 != null ? '${data1['tdp']}w' : '0w'),
                          leftRow("Soc",
                              data1 != null ? '${data1['socket']}' : 'NA'),
                          leftRow("Fam",
                              data1 != null ? '${data1['family']}' : 'NA'),
                          leftRow(
                              "Arquit",
                              data1 != null
                                  ? '${data1['architecture']}'
                                  : 'NA'),
                          leftRow("PCI E",
                              data1 != null ? '${data1['pciExpress']}' : 'NA'),
                          leftRow(
                              "Gráfica ",
                              data1 != null
                                  ? '${data1['integratedGpu']}'
                                  : 'NA'),
                          leftRow("Pre",
                              data1 != null ? '\$${data1['price']}' : '\$0'),
                          leftRow("Gene",
                              data1 != null ? '\$${data1['generation']}' : '0'),
                        ],
                      ),
                    ),
                  ),
                  //Container(
                  //  width: 1,
                  //  color: Colors.black,
                  //),
                  Expanded(
                    child: Container(
                      color: (data2?['brand'] == 'AMD')
                          ? Colors.orange
                          : (data2?['brand'] == 'INTEL')
                              ? Colors.blue
                              : isDarkMode
                                  ? Colors.grey[850]
                                  : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: selectButtonStyle(),
                              onPressed: () {
                                Provider.of<CpuComparatorProvider>(context,
                                        listen: false)
                                    .updateState(true);

                                Provider.of<CpuComparatorProvider>(context,
                                        listen: false)
                                    .setLastButtonPressed(
                                        "left"); // Actualizar el último botón presionado

                                // Navigator.popAndPushNamed(
                                //     context, 'viewAllProcessors');

                                Navigator.pushNamed(
                                    context, 'viewAllProcessors');
                              },
                              child: Text(
                                data2 != null ? '${data2['fullName']}' : '+',
                                style: selectTextButtonStyle(),
                              ),
                            ),
                          ),
                          rightRow(
                              "elo", data2 != null ? '${data2['model']}' : '0'),
                          rightRow(
                              "res", data2 != null ? '${data2['cores']}' : '0'),
                          rightRow("os",
                              data2 != null ? '${data2['threads']}' : '0'),
                          rightRow("ia Máxima",
                              data2 != null ? '${data2['maxFreq']}' : '0.0'),
                          rightRow("ia Mínima",
                              data2 != null ? '${data2['minfreq']}' : '0.0'),
                          rightRow(
                              " fabricación",
                              data2 != null
                                  ? '${data2['lithography']}nm'
                                  : '0nm'),
                          rightRow(
                              "P", data2 != null ? '${data2['tdp']}w' : '0w'),
                          rightRow("ket",
                              data2 != null ? '${data2['socket']}' : 'NA'),
                          rightRow("ilia",
                              data2 != null ? '${data2['family']}' : 'NA'),
                          rightRow(
                              "ectura",
                              data2 != null
                                  ? '${data2['architecture']}'
                                  : 'NA'),
                          rightRow("xpress",
                              data2 != null ? '${data2['pciExpress']}' : 'NA'),
                          rightRow(
                              "Integrada",
                              data2 != null
                                  ? '${data2['integratedGpu']}'
                                  : 'NA'),
                          rightRow("cio",
                              data2 != null ? '\$${data2['price']}' : '\$0'),
                          rightRow("ración",
                              data2 != null ? '${data2['generation']}' : '0'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container leftRow(String upperText, String lowerText) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1.0),
          bottom: BorderSide(color: Colors.black, width: 1.0),
          left: BorderSide(color: Colors.black, width: 1.0),
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFF353535),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(9.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(upperText, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lowerText,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }

  Container rightRow(String upperText, String lowerText) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1.0),
          bottom: BorderSide(color: Colors.black, width: 1.0),
          right: BorderSide(color: Colors.black, width: 1.0),
        ),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.0),
            topRight: Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFF353535),
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(9.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(upperText, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lowerText,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }

  TextStyle selectTextButtonStyle() =>
      const TextStyle(color: Colors.black, fontSize: 15.0);

  ButtonStyle selectButtonStyle() {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFFCBD7DD)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(color: Colors.black, width: 2),
      ),
    );
  }
}

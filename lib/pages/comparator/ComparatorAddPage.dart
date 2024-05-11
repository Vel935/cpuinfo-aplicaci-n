import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComparatorAddPage extends StatelessWidget {
  const ComparatorAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comparatorProvider = Provider.of<CpuComparatorProvider>(context);
    final data1 = comparatorProvider.data1;
    final data2 = comparatorProvider.data2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CPUINFO"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes controlar la acción cuando se presiona el botón de retroceso
            // Por ejemplo, puedes usar Navigator.popAndPushNamed para navegar a una página específica
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<CpuComparatorProvider>(context,
                                    listen: false)
                                .setLastButtonPressed(
                                    "right"); // Actualizar el último botón presionado

                            Provider.of<CpuComparatorProvider>(context,
                                    listen: false)
                                .updateState(true);

                            Navigator.pushNamed(context, 'viewAllProcessors');
                          },
                          child: Text(data1 != null ? '${data1['id']}' : '+'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
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

                            Navigator.pushNamed(context, 'viewAllProcessors');
                          },
                          child: Text(data2 != null ? '${data2['id']}' : '+'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

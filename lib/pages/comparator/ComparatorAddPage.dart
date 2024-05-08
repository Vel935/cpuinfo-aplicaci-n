import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComparatorAddPage extends StatelessWidget {
  const ComparatorAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //recibe la variable que contiene informacion del procesador elegido de la pagina de lista de procesadores
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final data = args["data"];

    return Scaffold(
      appBar: const MyAppBar(title: "CPUINFO"),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white, // Cambiar color a blanco
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
                            Navigator.pushNamed(context, 'viewAllProcessors');
                          },
                          child: Text(data), //boton izquierdo
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1, // Ancho de la línea
                color: Colors.black, // Color de la línea
              ),
              Expanded(
                child: Container(
                  color: Colors.white, // Cambiar color a blanco
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
                            Navigator.pushNamed(context, 'viewAllProcessors');
                          },
                          child: Text('+'), //boton derecho
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: MediaQuery.of(context).size.height / 2 - 30,
          //   left: MediaQuery.of(context).size.width / 2 - 60,
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     child: Text('Comparar!'),
          //   ),
          // ),
        ],
      ),
    );
  }
}

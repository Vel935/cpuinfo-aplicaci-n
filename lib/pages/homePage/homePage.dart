import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        alignment: Alignment.topLeft,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Qué quieres hacer?',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(
                  height: 20), // Separación entre el texto y los botones
              Padding(
                padding: const EdgeInsets.only(right: 110.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(),
                            onPressed: () {
                              // Navigator.pushNamed(context, 'comparatormenu',
                              //     arguments: {"data": ""});
                              Navigator.pushNamed(context, "comparatormenu");
                            },
                            child: Text(
                              'Comparar',
                              style: homeTextButtonStyle(),
                              //agrandar la letra
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Separación entre los botones
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(),
                            onPressed: () {
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateState(false);
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateActualPage("");
                              Navigator.pushNamed(context, 'viewAllProcessors');
                              // Acción para el botón "Ver"
                              // Puedes agregar aquí la navegación o acción deseada
                            },
                            child: Text(
                              'Ver',
                              style: homeTextButtonStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Separación entre los botones
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(),
                            onPressed: () {
                              Navigator.pushNamed(context, "cpuCrudPage");
                            },
                            child: Text(
                              'Modificar CPU',
                              style: homeTextButtonStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle homeTextButtonStyle() =>
      TextStyle(color: Colors.black, fontSize: 20.0);

  ButtonStyle homeButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFCBD7DD)),
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

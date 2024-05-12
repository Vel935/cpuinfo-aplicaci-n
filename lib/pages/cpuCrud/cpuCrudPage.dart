import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class cpuCrudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Colors.grey, // Add grey background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LargeButton(
                text: 'Añadir CPU',
                onPressed: () {
                  Navigator.pushNamed(context, "addCPU");
                },
              ),
              SizedBox(height: 20), // Espacio entre botones
              LargeButton(
                text: 'Modificar CPU',
                onPressed: () {
                  Provider.of<CpuComparatorProvider>(context, listen: false)
                      .updateActualPage("modifyCPU");
                  Navigator.pushNamed(context, 'viewAllProcessors');
                },
              ),
              SizedBox(height: 20), // Espacio entre botones
              LargeButton(
                text: 'Eliminar CPU',
                onPressed: () {
                  Provider.of<CpuComparatorProvider>(context, listen: false)
                      .updateActualPage("deleteCPU");
                  Navigator.pushNamed(context, 'viewAllProcessors');
                  // Acción para el botón 3
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: const Color(0xFF353535),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

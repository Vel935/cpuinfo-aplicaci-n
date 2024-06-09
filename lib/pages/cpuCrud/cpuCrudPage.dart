import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class cpuCrudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LargeButton(
                icon: Icons.add,
                text: 'Añadir CPU',
                onPressed: () {
                  Navigator.pushNamed(context, "addCPU");
                },
              ), // Espacio entre botones
              LargeButton(
                icon: Icons.edit,
                text: 'Modificar CPU',
                onPressed: () {
                  Provider.of<CpuComparatorProvider>(context, listen: false)
                      .updateActualPage("modifyCPU");
                  Navigator.pushNamed(context, 'viewAllProcessors');
                },
              ),
              LargeButton(
                icon: Icons.delete,
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
  final IconData icon;

  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
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
                  side: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  icon != null
                      ? Icon(
                          icon,
                          color: isDarkMode ? Colors.white : Colors.black,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

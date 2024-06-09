import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        // Cambiar el fondo basado en el modo oscuro o claro
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¿Qué quieres hacer?',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(
                  height: 20), // Separación entre el texto y los botones
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(isDarkMode),
                            onPressed: () {
                              Provider.of<CpuComparatorProvider>(
                                context,
                                listen: false,
                              ).updateActualPage("");
                              // Navigator.pushNamed(context, 'comparatormenu',
                              //     arguments: {"data": ""});
                              Navigator.pushNamed(context, "comparatormenu");
                            },
                            child: Text(
                              'Comparar',
                              style: homeTextButtonStyle(isDarkMode),
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
                            style: homeButtonStyle(isDarkMode),
                            onPressed: () {
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateState(false);
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateActualPage("");
                              Navigator.pushNamed(context, 'viewAllProcessors');
                            },
                            child: Text(
                              'Ver',
                              style: homeTextButtonStyle(isDarkMode),
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
                            style: homeButtonStyle(isDarkMode),
                            onPressed: () {
                              Navigator.pushNamed(context, "cpuCrudPage");
                            },
                            child: Text(
                              'Modificar CPU',
                              style: homeTextButtonStyle(isDarkMode),
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

  // Estilo de texto basado en el modo oscuro o claro
  TextStyle homeTextButtonStyle(bool isDarkMode) => TextStyle(
      color: isDarkMode ? Colors.white : Colors.black, fontSize: 20.0);

  // Estilo de botones basado en el modo oscuro o claro
  ButtonStyle homeButtonStyle(bool isDarkMode) {
    return ButtonStyle(
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 150)),
      backgroundColor: MaterialStateProperty.all<Color>(
          isDarkMode ? Color(0xFF444444) : Color(0xFFCBD7DD)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: isDarkMode ? Colors.white : Colors.black, width: 2),
      ),
    );
  }
}

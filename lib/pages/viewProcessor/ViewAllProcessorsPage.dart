import 'package:cpuinfo_application/pages/viewProcessor/ViewAllProcessorsController.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllProcessorsPage extends StatefulWidget {
  const ViewAllProcessorsPage({Key? key}) : super(key: key);

  @override
  State<ViewAllProcessorsPage> createState() => _ViewAllProcessorsPageState();
}

class _ViewAllProcessorsPageState extends State<ViewAllProcessorsPage> {
  ViewAllProcessorsController cpuController = ViewAllProcessorsController();
  List<String> selectedTags = []; // Lista de etiquetas seleccionadas
  List<String> availableTags = [
    'AMD',
    'Intel',
    'Desktop'
  ]; // Etiquetas disponibles
  List<String> availableFamilies = []; // Familias disponibles

  @override
  void initState() {
    super.initState();
    loadFamilies(); // Cargar familias al iniciar la página
  }

  Future<void> loadFamilies() async {
    List<String> families = await cpuController.getProcessorFamilies();
    setState(() {
      availableFamilies = families;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      appBar: MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: selectedTags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          selectedTags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  'Etiquetas: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: (isDarkMode ? Colors.white : Colors.grey[850])),
                ),
                SizedBox(height: 10),
                DropdownButton(
                  value: null,
                  hint: Text(
                    'Seleccionar etiquetas',
                    style: TextStyle(
                        color: (isDarkMode ? Colors.white : Colors.grey[850])),
                  ),
                  items: [...availableTags, ...availableFamilies].map((tag) {
                    return DropdownMenuItem(
                      value: tag,
                      child: Text(tag),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        if (value == 'AMD' || value == 'Intel') {
                          selectedTags.removeWhere(
                              (tag) => tag == 'AMD' || tag == 'Intel');
                        } else {
                          selectedTags.remove(value.toString());
                        }
                        selectedTags.add(value.toString());
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: getListView(),
          ),
          Container(
            width: MediaQuery.of(context)
                .size
                .width, // Ancho igual al ancho de la pantalla
            height: 50, // Altura específica del contenedor padre
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 50,
                    height: 70,
                    color: Color(
                        0xFFFF6600), // Color de fondo para la imagen izquierda
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!selectedTags.contains('AMD')) {
                            selectedTags.remove(
                                'Intel'); // Elimina Intel si está presente
                            selectedTags.add('AMD');
                          }
                        });
                        // Lógica para la imagen izquierda
                      },
                      child: Image.asset(
                        'assets/img/AMD.png',
                        // width: 100,
                        // height: 200, // Ruta de la imagen izquierda
                        // fit: BoxFit.cover, // Ajustar la imagen al contenedor
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 10),

                Expanded(
                  child: Container(
                    width: 50,
                    height: 70,
                    color: Color(
                        0xFF00B2FF), // Color de fondo para la imagen derecha
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!selectedTags.contains('Intel')) {
                            selectedTags
                                .remove('AMD'); // Elimina AMD si está presente
                            selectedTags.add('Intel');
                          }
                        });
                        // Lógica para la imagen derecha
                      },
                      child: Image.asset(
                        'assets/img/intel.png', // Ruta de la imagen derecha
                        // fit: BoxFit.cover, // Ajustar la imagen al contenedor
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getListView() {
    return FutureBuilder(
      future: cpuController.getProcessors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          dynamic processors = snapshot.data;
          List<dynamic> filteredProcessors = List.from(processors);

          // Aplicar filtros basados en etiquetas seleccionadas
          if (selectedTags.isNotEmpty) {
            filteredProcessors = processors.where((processor) {
              bool brandMatch = true;
              bool typeMatch = true;
              bool familyMatch = true;

              if (selectedTags.contains('AMD')) {
                brandMatch = processor['brand'].toLowerCase() == 'amd';
              }
              if (selectedTags.contains('Intel')) {
                brandMatch = processor['brand'].toLowerCase() == 'intel';
              }
              if (selectedTags.contains('Desktop')) {
                typeMatch = processor['type'].toLowerCase() == 'desktop';
              }

              // Verificar la coincidencia con la etiqueta de la familia
              if (selectedTags.any((tag) => availableFamilies.contains(tag))) {
                familyMatch = processor['family'] != null &&
                    selectedTags.contains(processor['family']);
              }

              return brandMatch && typeMatch && familyMatch;
            }).toList();
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: filteredProcessors.length,
              itemBuilder: (_, index) {
                var processor = filteredProcessors[index];
                if (!processor['visible']) {
                  return SizedBox(); // Retorna un contenedor vacío si el procesador no es visible
                }
                var name = processor["fullName"];
                var brand = processor['brand'];
                Color color;
                if (brand.toLowerCase() == 'intel') {
                  color = Colors.blue;
                } else if (brand.toLowerCase() == 'amd') {
                  color = Colors.orange;
                } else {
                  color = Colors.black;
                }
                final theme = Theme.of(context);
                var isDarkMode = theme.brightness == Brightness.dark;
                ;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                      onTap: () {
                        var theme = Theme.of(context);
                        var isDarkMode = theme.brightness == Brightness.dark;
                        var selected = Provider.of<CpuComparatorProvider>(
                          context,
                          listen: false,
                        ).actualPage;
                        if (selected == "modifyCPU") {
                          print("Modificar CPU");
                          print(processor.id);
                          Navigator.pushNamed(context, 'modifyCPU',
                              arguments: {"data": processor});
                          return;
                        } else if (selected == "deleteCPU") {
                          print("Eliminar CPU");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: isDarkMode
                                    ? Colors.grey[850]
                                    : Colors.white, // Cambiar el color de fondo
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Bordes redondeados
                                ),
                                title: Text(
                                  "Confirmar Eliminación",
                                  style: TextStyle(
                                    color: color, // Color del texto del título
                                    fontSize:
                                        20.0, // Tamaño del texto del título
                                    fontWeight: FontWeight.bold, // Negrita
                                  ),
                                ),
                                content: Text(
                                  "¿Estás seguro de que deseas eliminar este CPU?",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors
                                            .black, // Tamaño del texto del contenido
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Cerrar el diálogo
                                    },
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(
                                        color:
                                            color, // Color del texto del botón
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      CpuProvider()
                                          .deactivateProcessor(processor.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Se borró el procesador')));
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              'cpuCrudPage')); // Cerrar el diálogo
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          color, // Color de fondo del botón
                                    ),
                                    child: Text("Eliminar",
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black)),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        } else {
                          // Add a closing parenthesis here
                          print("Ver información del procesador");
                          Navigator.pushNamed(context,
                              "viewProcesorInformation", // Pasa la instantánea de documento
                              arguments: {"data": processor});
                        }
                      },
                      child: Container(
                        color: color,
                        child: ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.grey[850],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

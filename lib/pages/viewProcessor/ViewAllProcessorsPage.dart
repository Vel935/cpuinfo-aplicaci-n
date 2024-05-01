import 'package:cpuinfo_application/pages/viewProcessor/ViewAllProcessorsController.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';
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
        ''
  ]; // Etiquetas disponibles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CPUINFO'),
      ),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                DropdownButton(
                  value: null,
                  hint: Text('Seleccionar etiquetas'),
                  items: availableTags.map((tag) {
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

          if (selectedTags.isNotEmpty) {
            filteredProcessors = processors.where((processor) {
              bool brandMatch = true;
              bool typeMatch = true;

              if (selectedTags.contains('AMD')) {
                brandMatch = processor['brand'].toLowerCase() == 'amd';
              }
              if (selectedTags.contains('Intel')) {
                brandMatch = processor['brand'].toLowerCase() == 'intel';
              }
              if (selectedTags.contains('Desktop')) {
                typeMatch = processor['type'].toLowerCase() == 'desktop';
              }

              return brandMatch && typeMatch;
            }).toList();
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: filteredProcessors.length,
              itemBuilder: (_, index) {
                var processor = filteredProcessors[index];
                var docId = processor.id;
                var brand = processor['brand'];
                Color color;
                if (brand.toLowerCase() == 'intel') {
                  color = Colors.blue;
                } else if (brand.toLowerCase() == 'amd') {
                  color = Colors.orange;
                } else {
                  color = Colors.black;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: color,
                      child: ListTile(
                        title: Text(docId),
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

import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/models/cpus.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';
import 'package:flutter/material.dart';

class CreateCpuPage extends StatefulWidget {
  @override
  _CreateCpuPageState createState() => _CreateCpuPageState();
}

class _CreateCpuPageState extends State<CreateCpuPage> {
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _coresController = TextEditingController();
  final TextEditingController _generationController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  String _selectedBrand = 'INTEL'; // Default brand selection
  String _selectedType = 'Desktop'; // Default type selection

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese todos los campos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Colors.white, // Add gray background color
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedBrand,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBrand = newValue!;
                    });
                  },
                  items: <String>['INTEL', 'AMD']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Marca'),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items: <String>['Desktop', 'Laptop']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Tipo'),
                ),
                TextFormField(
                  controller: _familyController,
                  decoration: InputDecoration(labelText: 'Familia'),
                  validator: _validateInput,
                ),
                TextFormField(
                  controller: _frequencyController,
                  decoration: InputDecoration(labelText: 'Frecuencia (GHz)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: _validateInput,
                ),
                TextFormField(
                  controller: _coresController,
                  decoration: InputDecoration(labelText: 'Núcleos'),
                  keyboardType: TextInputType.number,
                  validator: _validateInput,
                ),
                TextFormField(
                  controller: _generationController,
                  decoration: InputDecoration(labelText: 'Generación'),
                  keyboardType: TextInputType.number,
                  validator: _validateInput,
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: InputDecoration(labelText: 'Modelo'),
                  keyboardType: TextInputType.number,
                  validator: _validateInput,
                ),
                //
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: const Color(0xFF353535),
                  ),
                  onPressed: () {
                    if (_validateInput(_familyController.text) == null &&
                        _validateInput(_frequencyController.text) == null &&
                        _validateInput(_coresController.text) == null &&
                        _validateInput(_generationController.text) == null &&
                        _validateInput(_modelController.text) == null) {
                      // All fields are valid, proceed with CPU creation
                      Cpu cpu = Cpu(
                        brand: _selectedBrand,
                        type: _selectedType,
                        family: _familyController.text,
                        freq: double.parse(_frequencyController.text),
                        cores: int.parse(_coresController.text),
                        visible: true, // Assuming default value is true
                        generation: int.parse(_generationController.text),
                        model: _modelController.text,
                      );

                      // Call method to create CPU in database
                      CpuProvider().createCPU(cpu.toJson()).then((response) {
                        //if response is not null, then the CPU was created successfully
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('El CPU se creó correctamente')));
                        // Handle response if needed
                        print('CPU created with ID: $response');
                        // You can navigate to another page or show a dialog
                      }).catchError((error) {
                        // Handle error if creation fails
                        print('Error creating CPU: $error');
                        // Show error message to user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al crear el CPU')),
                        );
                      });
                    } else {
                      // Show error message indicating required fields
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ingrese todos los campos')),
                      );
                    }
                  },
                  child: Text('Crear CPU',
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

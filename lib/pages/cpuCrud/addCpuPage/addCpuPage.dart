import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/pages/cpuCrud/addCpuPage/addCpuPageController.dart';
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
                // Dropdown y otros campos de entrada aquí...
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool fieldValidation() {
    return _familyController.text.isNotEmpty &&
        _frequencyController.text.isNotEmpty &&
        _coresController.text.isNotEmpty &&
        _generationController.text.isNotEmpty &&
        _modelController.text.isNotEmpty;
  }

  Future<void> _createCpu() async {
    if (fieldValidation()) {
      // Crear instancia del controlador
      CreateCpuController controller = CreateCpuController();

      try {
        // Llamar al método para crear la CPU
        String response = await controller.createCPU(
          brand: _selectedBrand,
          type: _selectedType,
          family: _familyController.text,
          freq: double.parse(_frequencyController.text),
          cores: int.parse(_coresController.text),
          generation: int.parse(_generationController.text),
          model: _modelController.text,
        );

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El CPU se creó correctamente')),
        );

        // Ir a la página anterior
        Navigator.pop(context);
      } catch (error) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el CPU')),
        );
      }
    } else {
      // Mostrar mensaje de validación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingrese todos los campos')),
      );
    }
  }
}

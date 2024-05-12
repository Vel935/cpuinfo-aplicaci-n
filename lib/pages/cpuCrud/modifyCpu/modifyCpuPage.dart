import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/pages/cpuCrud/addCpuPage/addCpuPageController.dart';
import 'package:cpuinfo_application/pages/cpuCrud/modifyCpu/modifyCpuController.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyCpuPage extends StatefulWidget {
  @override
  _ModifyCpuPageState createState() => _ModifyCpuPageState();
}

class _ModifyCpuPageState extends State<ModifyCpuPage> {
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _coresController = TextEditingController();
  final TextEditingController _generationController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  TextEditingController _idController = TextEditingController();

  String _selectedBrand = 'INTEL'; // Default brand selection
  String _selectedType = 'Desktop'; // Default type selection

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese todos los campos';
    }
    return null;
  }

  final ModifyCpuController _cpuController = ModifyCpuController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final snapshot = args["data"] as DocumentSnapshot; // Cambio aquí
    final data = snapshot.data() as Map<String, dynamic>; // Cambio aquí

    _familyController.text = data['family'];
    _frequencyController.text = data['freq'].toString();
    _coresController.text = data['cores'].toString();
    _generationController.text = data['generation'].toString();
    _modelController.text = data['model'];
    _selectedBrand = data['brand'];
    _selectedType = data['type'];

    _idController.text = snapshot.id;

    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: const Color(0xFF353535),
                  ),
                  onPressed: _modifyCpu,
                  child: Text(
                    'Modificar CPU',
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modifyCpu() {
    if (fieldValidation()) {
      _cpuController
          .modifyCpu(
        brand: _selectedBrand,
        type: _selectedType,
        family: _familyController.text,
        freq: double.parse(_frequencyController.text),
        cores: int.parse(_coresController.text),
        generation: int.parse(_generationController.text),
        model: _modelController.text,
        id: _idController.text,
      )
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CPU modificado correctamente')),
        );
        //Navigator.pop(context); // Regresar a la página anterior
        //Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.popUntil(context, ModalRoute.withName('cpuCrudPage'));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al modificar CPU')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingrese todos los campos')),
      );
    }
  }

  bool fieldValidation() {
    return _validateInput(_familyController.text) == null &&
        _validateInput(_frequencyController.text) == null &&
        _validateInput(_coresController.text) == null &&
        _validateInput(_generationController.text) == null &&
        _validateInput(_modelController.text) == null;
  }
}

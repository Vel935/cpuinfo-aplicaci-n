import 'package:cpuinfo_application/models/cpus.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';

class ModifyCpuController {
  Future<void> modifyCpu({
    required String brand,
    required String type,
    required String family,
    required double minfreq,
    required int cores,
    required int generation,
    required String model,
    required String socket,
    required String integratedGpu,
    required String architecture,
    required int lithography,
    required int tdp,
    required int price,
    required int threads,
    required double maxFreq,
    required double pciExpress,
    required String id,
    required String fullName,
  }) async {
    // Lógica para crear la CPU y guardarla en la base de datos
    Cpu cpu = Cpu(
      brand: brand,
      type: type,
      family: family,
      minfreq: minfreq,
      cores: cores,
      generation: generation,
      model: model,
      visible: true,
      socket: socket,
      integratedGpu: integratedGpu,
      architecture: architecture,
      lithography: lithography,
      tdp: tdp,
      price: price,
      threads: threads,
      maxFreq: maxFreq,
      pciExpress: pciExpress,
      fullName: brand + ' ' + family + ' ' + model + '',
    );

    // Llamar al método para crear la CPU en la base de datos
    try {
      await CpuProvider().modifyProcessor(id, cpu.toJson());
      print('CPU Actualizado Correctamente');
      // Puedes devolver el ID de la CPU creada si lo necesitas
    } catch (error) {
      print('Error al modificar CPU: $error');
      // Puedes lanzar una excepción o manejar el error de otra manera
      throw Exception('Error al modificar CPU');
    }
  }
}

//metodo para modificar el cpu en la pagina cpuProvider


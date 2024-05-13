import 'package:cpuinfo_application/models/cpus.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';

class CreateCpuController {
  Future<void> createCpu({
    required String brand,
    required String type,
    required String family,
    required double freq,
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
  }) async {
    // Lógica para crear la CPU y guardarla en la base de datos
    Cpu cpu = Cpu(
      brand: brand,
      type: type,
      family: family,
      minfreq: freq,
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
      fullName: '$brand $family $model',
    );

    // Llamar al método para crear la CPU en la base de datos
    try {
      String response = await CpuProvider().createCPU(cpu.toJson());
      print('CPU created with ID: $response');
      // Puedes devolver el ID de la CPU creada si lo necesitas
    } catch (error) {
      print('Error creating CPU: $error');
      // Puedes lanzar una excepción o manejar el error de otra manera
      throw Exception('Error creating CPU');
    }
  }
}

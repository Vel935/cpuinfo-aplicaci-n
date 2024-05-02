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
  }) async {
    // Lógica para crear la CPU y guardarla en la base de datos
    Cpu cpu = Cpu(
      brand: brand,
      type: type,
      family: family,
      freq: freq,
      cores: cores,
      generation: generation,
      model: model,
      visible: true,
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

// create_cpu_controller.dart

import 'package:cpuinfo_application/models/cpus.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';

class CreateCpuController {
  final CpuProvider _cpuProvider = CpuProvider();

  Future<String> createCPU({
    required String brand,
    required String type,
    required String family,
    required double freq,
    required int cores,
    required int generation,
    required String model,
  }) async {
    // Lógica de validación opcional

    // Crear el objeto CPU
    Cpu cpu = Cpu(
      brand: brand,
      type: type,
      family: family,
      freq: freq,
      cores: cores,
      visible: true,
      generation: generation,
      model: model,
    );

    // Llamar al método del proveedor para crear la CPU en Firestore
    try {
      String response = await _cpuProvider.createCPU(cpu.toJson());
      return response;
    } catch (error) {
      // Manejar el error adecuadamente
      throw error;
    }
  }
}

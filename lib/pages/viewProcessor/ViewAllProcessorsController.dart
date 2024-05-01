import 'package:cpuinfo_application/pages/viewProcessor/ViewAllProcessorsPage.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';

class ViewAllProcessorsController {
  CpuProvider cpuProvider = CpuProvider();

  Future getProcessors() async {
    return cpuProvider.getProcessors();
  }

  Future<List<String>> getProcessorFamilies() async {
    // Lógica para obtener las familias de los procesadores desde la base de datos
    // Supongamos que obtienes una lista de nombres de familias
    List<String> families = await cpuProvider.getProcessorsFamilies();
    // Lógica para obtener las familias desde la base de datos;
    return families;
  }
}

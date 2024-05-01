import 'package:cpuinfo_application/pages/viewProcessor/ViewAllProcessorsPage.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';

class ViewAllProcessorsController {
  CpuProvider cpuProvider = CpuProvider();

  Future getProcessors() async {
    return cpuProvider.getProcessors();
  }
}

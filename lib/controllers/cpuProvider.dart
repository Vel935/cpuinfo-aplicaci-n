import 'package:cpuinfo_application/models/cpus.dart';
import 'package:flutter/foundation.dart';

class CpuProvider extends ChangeNotifier {
  // Lista privada
  List<Cpu> _cpus = [];

// Lista pública
  List<Cpu> get cpus => _cpus;

  addCpu(Cpu cpu) {
    _cpus.add(cpu);
    notifyListeners();
  }

  void deleteCpu(Cpu cpu) {
    _cpus.remove(cpu);
    notifyListeners();
  }

  void changeVisibility(Cpu cpu) {
    if (cpu.visible == true) {
      cpu.visible = false;
    } else {
      cpu.visible = true;
    }
    notifyListeners();
  }
}

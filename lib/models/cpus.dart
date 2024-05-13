class Cpu {
  late String type;
  late String brand;
  late String family;
  late double minfreq;
  late int cores;
  late bool visible;
  late int generation;
  late String model;
  late String socket;
  late String integratedGpu;
  late String architecture;
  late int lithography;
  late int tdp;
  late int price;
  late int threads;
  late double maxFreq;
  late double pciExpress;
  late String fullName;

  Cpu({
    required this.type,
    required this.brand,
    required this.family,
    required this.minfreq,
    required this.cores,
    required this.visible,
    required this.generation,
    required this.model,
    required this.socket,
    required this.integratedGpu,
    required this.architecture,
    required this.lithography,
    required this.tdp,
    required this.price,
    required this.threads,
    required this.maxFreq,
    required this.pciExpress,
    required this.fullName,
  });

  Cpu.empty() {
    type = "";
    brand = "";
    family = "";
    minfreq = 0.0;
    cores = 0;
    visible = true;
    generation = 0;
    model = "";
    socket = "";
    integratedGpu = "";
    architecture = "";
    lithography = 0;
    tdp = 0;
    price = 0;
    threads = 0;
    maxFreq = 0.0;
    pciExpress = 0.0;
    fullName = "";
  }

  // toJson method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'brand': brand,
      'family': family,
      'minfreq': minfreq,
      'cores': cores,
      'visible': visible,
      'generation': generation,
      'model': model,
      'socket': socket,
      'integratedGpu': integratedGpu,
      'architecture': architecture,
      'lithography': lithography,
      'tdp': tdp,
      'price': price,
      'threads': threads,
      'maxFreq': maxFreq,
      'pciExpress': pciExpress,
      'fullName': fullName,
    };
  }
}

import 'package:flutter/material.dart';

class Cpu {
  late String type;
  late String brand;
  late String family;
  late double freq;
  late int cores;
  late bool visible;
  late int generation;
  late String model;

  Cpu(
      {required this.type,
      required this.brand,
      required this.family,
      required this.freq,
      required this.cores,
      required this.visible,
      required this.generation,
      required this.model});

  Cpu.empty() {
    type = "";
    brand = "";
    family = "";
    freq = 0.0;
    cores = 0;
    visible = true;
    generation = 0;
    model = "";
  }

  // toJson method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'brand': brand,
      'family': family,
      'freq': freq,
      'cores': cores,
      'visible': visible,
      'generation': generation,
      'model': model
    };
  }
}

import 'package:flutter/material.dart';

class Cpu {
  late String type;
  late String name;
  late String description;
  late String color;
  late bool visible;

  Cpu(
      {required this.type,
      required this.name,
      required this.description,
      required this.color,
      required this.visible});

  Cpu.empty() {
    type = "";
    name = "";
    description = "";
    color = "";
    visible = true;
  }
}

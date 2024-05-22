import 'dart:core';
import 'empleado.dart';

class Jefe implements Empleado {
  late String nombre;
  final List<Empleado> empleados = [];

  Jefe(String nomb) {
    nombre = nomb;
  }

  Jefe.empty() {
    nombre = "";
  }

  void aniadeEmpleado(Empleado empleado) {
    empleados.add(empleado);
  }

  //AÑADIDA
  void eliminaEmpleado(Empleado empleado) {
    empleados.remove(empleado);
  }

  @override
  String getNombre() {
    return "Jefe - $nombre";
  }

  List<Empleado> getEquipo() {
    return empleados;
  }
}

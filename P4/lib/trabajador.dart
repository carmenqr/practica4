import 'empleado.dart';

class Trabajador implements Empleado {
  late String _nombre;

  Trabajador(String nombre) {
    _nombre = nombre;
  }

  @override
  String getNombre() {
    return "Trabajador - $_nombre";
  }
}

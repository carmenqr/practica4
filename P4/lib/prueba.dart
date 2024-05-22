import 'dart:io';
import 'evento_builder.dart';
import 'organizador.dart';
import 'jefe.dart';
import 'trabajador.dart';
import 'conferencia_builder.dart';
import 'boda_builder.dart';

void main() {
  var scanner = stdin;
  EventoBuilder builder;
  Organizador directorOrg;
  String nombreEvento, fechaEvento, ubicacionEvento;
  List<Jefe> jefes = [];
  List<Organizador> organizadores = [];

  stdout.write("Numero de jefes deseados: ");
  var numJefes = int.parse(scanner.readLineSync()!);

  for (var i = 0; i < numJefes; i++) {
    stdout.write("Nombre del jefe numero ${i + 1}: ");
    var nombreJefe = scanner.readLineSync()!;
    var jefe = Jefe(nombreJefe);

    stdout.write("Numero de empleados a cargo de $nombreJefe: ");
    var numEmpleados = int.parse(scanner.readLineSync()!);

    for (var j = 0; j < numEmpleados; j++) {
      stdout.write("Nombre del empleado numero ${j + 1}: ");
      var nombreTrabajador = scanner.readLineSync()!;
      stdout.write("¿Qué tipo de empleado es $nombreTrabajador? (Organizador=1, Jefe=2, Trabajador=3): ");
      var tipoEmpleado = int.parse(scanner.readLineSync()!);

      switch (tipoEmpleado) {
        case 1:
          var organizador = Organizador(nombreTrabajador);
          organizadores.add(organizador);
          jefe.aniadeEmpleado(organizador);
          break;
        case 2:
          var jefeEmpleado = Jefe(nombreTrabajador);
          jefe.aniadeEmpleado(jefeEmpleado);
          break;
        case 3:
          var trabajador = Trabajador(nombreTrabajador);
          jefe.aniadeEmpleado(trabajador);
          break;
        default:
          stdout.write("No se ha introducido un tipo válido. No se añade.");
          break;
      }
    }
    jefes.add(jefe);
  }

  if (organizadores.isEmpty) {
    stdout.write("No se ha añadido ningun organizador, añada uno por favor: ");
    var nombreOrganizador = scanner.readLineSync()!;
    var organizador = Organizador(nombreOrganizador);
    stdout.write("¿De qué jefe es empleado este organizador?: ");
    for (var i = 0; i < jefes.length; i++) {
      stdout.write("${i + 1}- ${jefes[i].getNombre()}\n");
    }
    var indice = int.parse(scanner.readLineSync()!) - 1;
    jefes[indice].aniadeEmpleado(organizador);
    organizadores.add(organizador);
  }

  stdout.write("¿Cual de los siguientes empleados desea que organice el evento?: \n");
  for (var i = 0; i < organizadores.length; i++) {
    stdout.write("${i + 1}- ${organizadores[i].getNombre()}\n");
  }
  var organizadorElegido = int.parse(scanner.readLineSync()!) - 1;

  stdout.write("¿Qué tipo de evento desea crear? (Conferencia=1, Boda=2): ");
  var tipoEvento = int.parse(scanner.readLineSync()!);

  if (tipoEvento == 1) {
    builder = ConferenciaBuilder();
    directorOrg = organizadores[organizadorElegido];
    directorOrg.setBuilder(builder);

    stdout.write("Nombre del evento: ");
    nombreEvento = "Conferencia ${scanner.readLineSync()!}";

    stdout.write("Fecha del evento: ");
    fechaEvento = scanner.readLineSync()!;

    stdout.write("Ubicación del evento: ");
    ubicacionEvento = scanner.readLineSync()!;

    directorOrg.construirEvento(nombreEvento, fechaEvento, ubicacionEvento);

    var conferencia = directorOrg.getEvento();
    stdout.write("\n-----------------------------------------\n");
    stdout.write("${directorOrg.getNombre()}\n");
    conferencia.mostrarEvento();
    stdout.write("-----------------------------------------\n");
  } else if (tipoEvento == 2) {
    builder = BodaBuilder();
    directorOrg = organizadores[organizadorElegido];
    directorOrg.setBuilder(builder);

    stdout.write("Nombre del evento: ");
    nombreEvento = "Boda ${scanner.readLineSync()!}";

    stdout.write("Fecha del evento: ");
    fechaEvento = scanner.readLineSync()!;

    stdout.write("Ubicación del evento: ");
    ubicacionEvento = scanner.readLineSync()!;

    directorOrg.construirEvento(nombreEvento, fechaEvento, ubicacionEvento);

    var boda = directorOrg.getEvento();
    stdout.write("\n-----------------------------------------\n");
    stdout.write("${directorOrg.getNombre()}\n");
    stdout.write("${boda.mostrarEvento()}\n");
    stdout.write("-----------------------------------------\n");
  } else {
    stdout.write("Tipo de evento no reconocido");
  }

  for (var i = 0; i < jefes.length; i++) {
    stdout.write("Empleados a cargo de ${jefes[i].getNombre()}:\n");
    var cargo = jefes[i].getEquipo();

    for (var j = 0; j < cargo.length; j++) {
      stdout.write("${cargo[j].getNombre()}\n");
    }
  }
}

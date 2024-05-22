import 'evento.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class GestorEventos{
  List<Evento> misEventos  = [];
  final String apiUrl = "http://localhost:3000/eventos";

  GestorEventos (this.misEventos);

  Future<void> cargarEventos(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> tareasJson = json.decode(response.body);

      misEventos.clear();
      misEventos.addAll(tareasJson.map((json) => Evento.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load eventos');
    }
  }

  Future<void> agregar(Evento evento) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(evento.toJson()),
    );
    if (response.statusCode == 201) {
      misEventos.add(Evento.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add evento: ${response.body}');
    }
  }

  Future<void> eliminar(Evento evento) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/${evento.id}'),
    );
    if (response.statusCode == 200) {
      misEventos.removeWhere((t) => t.id == evento.id);
    } else {
      throw Exception('Failed to delete evento');
    }
  }

  //Se carga localmente en quien lo edite, pero en la bd esta guardado el usuario de quien lo creo originalmente.
  Future<void> actualizarEvento(Evento evento, String nuevoNombre, String nuevaUbicacion, String nuevaFecha) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/${evento.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombre': nuevoNombre,
        'ubicacion': nuevaUbicacion,
        'fecha': nuevaFecha,
      }),
    );
    /*if (response.statusCode == 200) {
      // Actualizar el evento localmente con los nuevos valores
      evento.nombre = nuevoNombre;
      evento.ubicacion = nuevaUbicacion;
      evento.fecha = nuevaFecha;
    }*/ if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }


}

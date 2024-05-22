class Evento {
  String? nombre;
  String? fecha;
  String? ubicacion;
  String? usuario;
  String? nombreJefe;
  String? nombreOrg;
  int? id;

  //No hacen falta getters y setters en dart

  // Constructor por defecto
  Evento({this.id, this.nombre, this.fecha, this.ubicacion, this.usuario, this.nombreOrg, this.nombreJefe});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      fecha: json['fecha'] as String?,
      ubicacion: json['ubicacion'] as String?,
      nombreJefe: json['nombreJefe'] as String?,
      nombreOrg: json['nombreOrg'] as String?,
      usuario: json['usuario'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'fecha': fecha,
      'ubicacion': ubicacion,
      'nombreJefe': nombreJefe,
      'nombreOrg': nombreOrg,
      'usuario': usuario,
    };
  }


  @override
  String toString() {
    return 'Evento: $nombre, Fecha: $fecha, Ubicación: $ubicacion, nombreJefe: $nombreJefe, nombreOrg: $nombreOrg, Usuario: $usuario';
  }

  String mostrarEvento() {
    String infoEvento = '''
      Nombre del evento: $nombre
      Fecha del evento: $fecha
      Ubicación del evento: $ubicacion
      ''';
    return infoEvento;
  }
}

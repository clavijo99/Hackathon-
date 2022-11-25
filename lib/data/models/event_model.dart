class EventModel {
  EventModel({
    required this.nombre,
    required this.type,
    required this.destacado,
    required this.descripcion,
    required this.lugar,
    required this.imagen,
    required this.hora,
    required this.fecha,
    required this.latitud,
    required this.longitud,
  });

  final String nombre;
  final String type;
  final bool destacado;
  final String descripcion;
  final String lugar;
  final String imagen;
  final String hora;
  final String fecha;
  final String latitud;
  final String longitud;
}

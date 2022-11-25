import 'dart:convert';
import 'package:alcaldia_event/data/models/categorie_model.dart';
import 'package:alcaldia_event/data/models/event_model.dart';
import 'package:flutter/services.dart';

class DataService {
  Future<List<EventModel>> getEvents() async {
    final String response =
        await rootBundle.loadString('assets/data/events.json');
    final List<dynamic> data = await json.decode(response);
    List<EventModel> newData = data
        .map((e) => EventModel(
            nombre: e['nombre'],
            descripcion: e['descripcion'],
            destacado: e['destacado'],
            fecha: e['fecha'],
            hora: e['hora'],
            imagen: e['imagen'],
            latitud: e['latitud'],
            longitud: e['longitud'],
            lugar: e['lugar'],
            type: e['type']))
        .toList();
    print(data[0]);
    return newData;
  }

  Future<List<CategorieModel>> getCategories() async {
    final String response =
        await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> data = await json.decode(response);
    List<CategorieModel> newData =
        data.map((e) => CategorieModel(e['categorie'])).toList();
    return newData;
  }
}

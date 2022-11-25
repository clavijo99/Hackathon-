import 'package:alcaldia_event/data/models/categorie_model.dart';
import 'package:alcaldia_event/data/models/event_model.dart';
import 'package:alcaldia_event/data/service/data_service.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({required this.dataService});
  final DataService dataService;

  int? indexMenu;
  List<CategorieModel>? categories;
  List<EventModel>? eventsTotal = [];
  List<EventModel>? events = [];
  List<EventModel>? eventsDestacados = [];

  void init() {
    getCategorie();
    getEvents();
  }

  Future<void> getCategorie() async {
    categories = await dataService.getCategories();
    notifyListeners();
  }

  Future<void> getEvents() async {
    eventsTotal = await dataService.getEvents();
    for (var element in eventsTotal!) {
      print(element);
      if (element.type == categories![0].categorie) {
        events!.add(element);
        if (element.destacado) {
          eventsDestacados!.add(element);
        }
      }
    }
    print(events);
    notifyListeners();
  }

  void setIndexMenu(int index) {
    events = [];
    eventsDestacados = [];
    indexMenu = index;
    for (var element in eventsTotal!) {
      print(element);
      if (element.type == categories![index].categorie) {
        events!.add(element);
        if (element.destacado) {
          eventsDestacados!.add(element);
        }
      }
    }
    notifyListeners();
  }
}

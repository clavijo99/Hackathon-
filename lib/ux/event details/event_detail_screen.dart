import 'package:alcaldia_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

const tokenMap =
    'pk.eyJ1IjoiY2FtaWxvOTlnb21leiIsImEiOiJja3cxOHJqYm0xNWxtMm9sdHcyYWFoMGV0In0._CWfIbdxIYSKEwZv-hl2Kw';
const styleMap = 'mapbox/light-v10';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF00B6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Hero(
              tag: event.imagen,
              child: Image.network(
                event.imagen,
                height: 300,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  event.nombre,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(event.descripcion),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(double.parse(event.latitud),
                      double.parse(event.longitud)),
                  maxZoom: 22,
                  minZoom: 10,
                  zoom: 18,
                  onTap: (tapPosition, point) {
                    //print(point);
                  },
                  onMapReady: () {
                    print("onre");
                  },
                  onPointerHover: (event, point) {
                    //print(event);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={access_token}',
                    additionalOptions: const {
                      'access_token': tokenMap,
                      'id': styleMap,
                    },
                    maxZoom: 22,
                    minZoom: 10,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(double.parse(event.latitud),
                            double.parse(event.longitud)),
                        builder: (context) {
                          return Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF00B6FF),
                              size: 25,
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              height: 5,
              color: Color(0xFF2B5AC3),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/Me gusta.svg",
                        width: 25,
                      ),
                      const SizedBox(width: 15),
                      SvgPicture.asset(
                        "assets/images/Compartir.svg",
                        width: 25,
                      ),
                    ],
                  ),
                  Column(
                    children: [Text("Fecha: ${event.fecha}")],
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

import 'package:alcaldia_event/data/service/data_service.dart';
import 'package:alcaldia_event/ux/event%20details/event_detail_screen.dart';
import 'package:alcaldia_event/ux/home/home_provider.dart';
import 'package:alcaldia_event/ux/home/widgets/drawer_custom.dart';
import 'package:alcaldia_event/ux/home/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(
        dataService: Provider.of<DataService>(context, listen: false),
      )
        ..init()
        ..setIndexMenu(0),
      builder: (_, child) => const HomeScreen._(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final bloc = Provider.of<HomeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final bloc = Provider.of<HomeProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              width: size.width,
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState!.openDrawer(),
                      child: SvgPicture.asset(
                        "assets/images/menu.svg",
                        width: 32,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/images/Logo.svg",
                      width: (size.width > 1000)
                          ? size.width * 0.15
                          : size.width * 0.45,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SliderCustom(),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                      child: Text(
                        (bloc.categories != null)
                            ? bloc.categories![bloc.indexMenu!].categorie
                            : "",
                        style: TextStyle(
                          color: Color(0xFF00B6FF).withOpacity(0.45),
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: (size.width > 1000)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: size.width,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return EventItem(
                                    index: index,
                                  );
                                },
                                itemCount: bloc.events!.length,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return EventItem(
                                index: index,
                              );
                            },
                            itemCount: bloc.events!.length,
                            physics: const BouncingScrollPhysics(),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventScreen(event: bloc.events![index]),
        )),
        child: Container(
          width: (size.width > 1000) ? 100 : size.width,
          height: (size.width > 1000) ? 800 : size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            // color: const Color(0xFFE6E6E6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Hero(
                      tag: bloc.events![index].imagen,
                      child: Image.network(
                        bloc.events![index].imagen,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    )),
              ),
              SizedBox(height: 10),
              Text(
                bloc.events![index].nombre,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(bloc.events![index].descripcion),
              ),
              SizedBox(height: 10),
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
                        SizedBox(width: 15),
                        SvgPicture.asset(
                          "assets/images/Compartir.svg",
                          width: 25,
                        ),
                      ],
                    ),
                    Column(
                      children: [Text("Fecha: ${bloc.events![index].fecha}")],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

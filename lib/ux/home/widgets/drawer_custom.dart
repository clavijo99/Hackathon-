import 'package:alcaldia_event/ux/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bloc = Provider.of<HomeProvider>(context);

    return Container(
      width: (size.width > 1000) ? size.width * 0.15 : size.width * 0.5,
      height: size.height,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 15),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  size: 40,
                  color: Color(0xFF00B6FF),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return DrawerItem(
                  index: index,
                );
              },
              itemCount: bloc.categories!.length,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => bloc.setIndexMenu(index),
        child: Card(
            color: (bloc.indexMenu == index) ? Color(0xFF00B6FF) : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bloc.categories![index].categorie,
                style: TextStyle(
                    color: (bloc.indexMenu == index)
                        ? Colors.white
                        : Colors.black),
              ),
            )),
      ),
    );
  }
}

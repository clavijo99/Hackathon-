import 'package:alcaldia_event/ux/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class SliderCustom extends StatefulWidget {
  const SliderCustom({super.key});

  @override
  State<SliderCustom> createState() => _SliderSaleProductState();
}

class _SliderSaleProductState extends State<SliderCustom> {
  late final Timer time;
  late final PageController pageController;

  @override
  void initState() {
    final bloc = Provider.of<HomeProvider>(context, listen: false);

    pageController = PageController(initialPage: 0, keepPage: false);
    time = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (pageController.page == bloc.eventsDestacados!.length - 1) {
        pageController.jumpToPage(0);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bloc = Provider.of<HomeProvider>(context);
    return SizedBox(
      width: size.width,
      height: (size.width > 1000) ? 250 : 140,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        bloc.eventsDestacados![index].imagen,
                        fit: BoxFit.cover,
                      ),
                      //add image
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: bloc.eventsDestacados!.length,
        physics: const NeverScrollableScrollPhysics(),
        reverse: false,
        controller: pageController,
      ),
    );
  }
}

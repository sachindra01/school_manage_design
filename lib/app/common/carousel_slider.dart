import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

Widget bannerCarouseSlider(context,height,width) {
  return SizedBox(
      height: height??100.0,
      width: width??200.0,
      child: AnotherCarousel(
        overlayShadowColors: Colors.transparent,
        images: const [
          ExactAssetImage("assets/img/nature.jpg"),
          ExactAssetImage("assets/img/nature.jpg")
        ],
        dotSpacing: 6.0,
        dotColor: Colors.lightGreenAccent,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.purple.withOpacity(0.5),
        borderRadius: true,
      ));
}

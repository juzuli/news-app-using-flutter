import 'package:flutter/material.dart';

import '../model/api_response.dart';
import '../pages/detail_page.dart';
import 'custom_cached_image.dart';

class CarouselCard extends StatelessWidget {
  String imageUrl;
  Articles argument;

  CarouselCard({
    Key? key,
    required this.imageUrl,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: argument,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailPage(),
                settings: RouteSettings(
                  arguments: argument,
                ),
              ),
            );
          },
          child: Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              CustomCachedImage(
                imageUrl: imageUrl,
                height: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}

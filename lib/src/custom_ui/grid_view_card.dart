import 'package:citizens/src/model/api_response.dart';
import 'package:flutter/material.dart';

import '../pages/detail_page.dart';
import 'custom_cached_image.dart';

class GridViewCard extends StatelessWidget {
  String imageUrl;
  Articles argument;

  GridViewCard({
    Key? key,
    required this.imageUrl,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:argument,
      child: Material(
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomCachedImage(
              imageUrl: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}

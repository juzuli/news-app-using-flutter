import 'package:citizens/src/model/api_response.dart';
import 'package:flutter/material.dart';

import '../pages/detail_page.dart';
import 'custom_cached_image.dart';

class VerticalListViewCard extends StatelessWidget {
  String imageUrl;
  Articles argument;
  String title;
  String subtitle;

  VerticalListViewCard({
    Key? key,
    required this.imageUrl,
    required this.argument,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: argument,
              child: Material(
                child: CustomCachedImage(
                  imageUrl: imageUrl,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
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
        ),
        const Divider(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../model/api_response.dart';
import '../pages/detail_page.dart';
import 'custom_cached_image.dart';

class HorizontalListViewCard extends StatelessWidget {
  String? imageUrl;
  Articles argument;
  String? title;

  HorizontalListViewCard(
      {Key? key,
      required this.imageUrl,
      required this.argument,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: Container(
        height: 200,
        width: 319,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                //color: Colors.grey, //New
                blurRadius: 25.0,
                offset: Offset(0, -10))
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomCachedImage(imageUrl: imageUrl ?? ''),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              left: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                   // color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

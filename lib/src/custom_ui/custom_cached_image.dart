import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImage extends StatelessWidget {

  String imageUrl;
  double? width;
  double? height;

  CustomCachedImage({
    Key? key,
    required this.imageUrl,this.width,this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>  Shimmer.fromColors(
          child: Container(
            color: Colors.black,
          ), baseColor: Colors.black12,
        highlightColor: Colors.white,
      ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
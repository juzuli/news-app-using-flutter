import 'package:citizens/src/model/api_response.dart';
import 'package:flutter/material.dart';

import '../custom_ui/custom_cached_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final res = ModalRoute.of(context)!.settings.arguments as Articles;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers:[
            SliverAppBar(
              expandedHeight: 232,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: res,
                    child: Material(
                      color: Colors.transparent,
                        child: CustomCachedImage(imageUrl: res.urlToImage??'')))
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          res.title ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          res.author ?? '',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          res.publishedAt ?? '',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          res.description ?? '',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
          // appBar: AppBar(
          //   title: Text(res.title ?? ''),
          // ),
        ),
      ),
    );
  }
}

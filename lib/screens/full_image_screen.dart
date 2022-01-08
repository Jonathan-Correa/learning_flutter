import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({
    Key? key,
    required this.imgId,
  }) : super(key: key);

  final String imgId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista de imagen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Hero(
            tag: imgId,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/id/$imgId/200/300',
              imageBuilder: (context, imageProvider) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: imageProvider,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

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
        title: Text('Vista de imagen'),
      ),
      body: Align(
        alignment: Alignment.bottomRight,
        child: Hero(
          tag: imgId,
          child: CachedNetworkImage(
            imageUrl: 'https://picsum.photos/id/$imgId/200/300',
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_flutter/screens/home_screen.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CarouselImages(
          imagesUrl: 'https://picsum.photos/v2/list',
          page: 1,
          limit: 10,
        ),
        CarouselImages(
          imagesUrl: 'https://picsum.photos/v2/list',
          page: 1,
          limit: 2,
        )
      ],
    );
  }
}

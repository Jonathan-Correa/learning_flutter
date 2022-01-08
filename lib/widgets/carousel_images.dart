import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/screens/full_image_screen.dart';
import 'package:test_flutter/services/images_service.dart';

/// Mustra un carousel de imagenes desde la ruta indicada
/// [page] indica la pagina que se quiere obtener
/// [limit] indica el numero de imagenes que se quieren obtener por cada pagina
class CarouselImages extends StatelessWidget {
  const CarouselImages({
    Key? key,
    required this.imagesUrl,
    required this.page,
    required this.limit,
  }) : super(key: key);

  final String imagesUrl;
  final int page;
  final int limit;

  @override
  Widget build(BuildContext context) {
    /// Ejecuta metodo asincrono y monitorea el proceso de ejecucion del mismo,
    /// cuando la funcion se esta ejecutando muestra un circulo girando, el cual
    /// indica que la peticion esta siendo procesada. Cuando la funcion termina,
    /// mustra la lista de imagenes
    return FutureBuilder(
      future: ImagesService.getImages(imagesUrl, page, limit),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final images = snapshot.data;

          if (images == null) {
            return const Text('No hay imagenes para mostrar');
          }

          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CarouselSlider(
              items: images.map((img) {
                return CarouselImageItem(
                  imgUrl: img['download_url'],
                  id: img['id'],
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
              ),
            ),
          );
        } else {
          return const Text('Hubo un error!');
        }
      },
    );
  }
}

/// Item para el carousel de items, define el estilo de cada imagen
class CarouselImageItem extends StatelessWidget {
  const CarouselImageItem({
    Key? key,
    required this.imgUrl,
    required this.id,
  }) : super(key: key);

  final String imgUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // Widget para moldear imagen, cambiar [borderRadius] etc...
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FullImageScreen(imgId: id);
            }),
          );
        },
        child: Hero(
          tag: id,
          child: CachedNetworkImage(
            imageUrl: imgUrl,
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
    );
  }
}

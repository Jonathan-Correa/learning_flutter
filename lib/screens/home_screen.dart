import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/screens/images_screen.dart';
import 'package:test_flutter/services/images_service.dart';
import 'package:test_flutter/services/users_service.dart';
import 'package:test_flutter/widgets/custom_list_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Define las vistas que pueden ser mostradas, segun el item que es pulsado
  /// en la navegacion inferior
  Map<int, Widget> screens = {
    0: const UsersList(),
    1: const ImagesScreen(),
  };

  /// Indica la pagina que sera mostrada, con respecto al map [screens]
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: screens[currentIndex],
      // body: ,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          // Cambiar el valor de la variable [currentIndex], y volver a ejecutar
          // la funcion [build], para que la vista cambie con respecto al elemento
          // pulsado
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Images',
          ),
        ],
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Ejecuta metodo asincrono y monitorea el proceso de ejecucion del mismo,
    /// cuando la funcion se esta ejecutando muestra un circulo girando, el cual
    /// indica que la peticion esta siendo procesada. Cuando la funcion termina,
    /// mustra la lista de usuarios
    return FutureBuilder(
      future: UsersService.getUsers(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final users = snapshot.data;
          return ListView(
            children: users != null
                ? users
                    .map((user) => CustomListItem(title: user['name']))
                    .toList()
                : [],
          );
        } else {
          return const Text('Hubo un error!');
        }
      },
    );
  }
}

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
                return CarouselImageItem(imgUrl: img['download_url']);
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
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // Widget para moldear imagen, cambiar [borderRadius] etc...
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(
            imgUrl,
          ),
        ),
      ),
    );
  }
}

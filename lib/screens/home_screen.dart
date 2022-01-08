import 'package:flutter/material.dart';
import 'package:test_flutter/screens/images_screen.dart';
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

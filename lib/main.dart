import 'package:flutter/material.dart';
import 'package:test_flutter/services/users_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> names = ['Jonathan', 'Daynlli', 'Carolina'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Primera App'),
      ),
      body: FutureBuilder(
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
      ),
      // body: ,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class CustomListItem extends StatefulWidget {
  const CustomListItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image(
              width: 50,
              height: 50,
              image: NetworkImage(
                'https://ui-avatars.com/api/?name=${widget.title}',
              ),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

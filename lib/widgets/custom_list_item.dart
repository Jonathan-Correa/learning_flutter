import 'package:flutter/material.dart';

/// Widget que define el estilo que tendra cada item de la lista de usuarios
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

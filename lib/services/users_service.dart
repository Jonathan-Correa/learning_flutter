import 'dart:convert';

import 'package:http/http.dart' as http;

class UsersService {
  static Future<List<dynamic>> getUsers() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('La respuesta no fue correcta');
  }
}

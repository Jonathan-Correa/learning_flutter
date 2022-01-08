import 'dart:convert';

import 'package:http/http.dart' as http;

class UsersService {
  static Future<List<dynamic>> getUsers() async {
    /// Parsear String a un objeto de tipo URI
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

    /// Esperar la resupuesta de la API
    final response = await http.get(url);

    /// Si la respuesta fue correcta, convertir el resultado a una lista dinamica (en este caso)
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    /// Si el codigo de la respuesta fue diferente a 200, devolver un error
    throw Exception('La respuesta no fue correcta');
  }
}

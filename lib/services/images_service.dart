import 'dart:convert';

import 'package:http/http.dart' as http;

class ImagesService {
  /// Obtener lista de imagenes desde la ruta indicada,
  /// [page] indica la pagina que se quiere obtener
  /// [limit] indica la cantidad de images que se quieren obtener por pagina
  static Future<List<dynamic>> getImages(
    String uri,
    int page,
    int limit,
  ) async {
    // Definir lo query (parametros) que recibe la ruta indicada
    Map<String, String> queryParams = {'page': '$page', 'limit': '$limit'};

    // Convertir los [queryParams] en un string que posteriormente sera concatenado
    // A la ruta.
    String queryString = Uri(queryParameters: queryParams).query;

    // Concatenar la ruta con los parametros [queryString]
    /// Ejemplo:
    ///   uri = https://picsum.photos/v2/list;
    ///   queryParams = {'page': 1, 'limit': 10};
    ///   resultadoFinal = https://picsum.photos/v2/list?page=1&limit=10
    final url = Uri.parse('$uri?$queryString');

    /// Esperar la respuesta de la api
    final response = await http.get(url);

    // Si la respuesta fue correcta, convertir el string a una lista dinamica (en este caso)
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    /// Si el codigo de la respuesta fue diferente a 200, devolver un error
    throw Exception('Hubo un error al cargar las imagenes');
  }
}

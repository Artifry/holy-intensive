import 'dart:convert';
import 'package:http/http.dart' as http;

class BibliaService {
  final String baseUrl = 'https://bible-api.com'; // 👈 SUA API AQUI

  Future<String> buscarVersiculo(String referencia) async {
    final response = await http.get(Uri.parse('$baseUrl/$referencia'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'];
    } else {
      throw Exception('Erro ao carregar versículo');
    }
  }
}

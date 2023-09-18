import 'dart:convert';
import 'package:http/http.dart' as http;

class SyncService {
  final String apiUrl = 'https://seuservidor.com/api/data'; // Substitua pela URL do seu servidor

  Future<bool> syncData(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      // Dados sincronizados com sucesso
      return true;
    } else {
      // Falha na sincronização, lide com o erro aqui
      return false;
    }
  }
}

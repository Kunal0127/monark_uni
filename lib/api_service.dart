import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchStudents() async {
  http.Response response =
      await http.get(Uri.parse('http://127.0.0.1:5000/student/'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return jsonData as List<dynamic>;
  } else {
    throw Exception('Failed to fetch students');
  }
}

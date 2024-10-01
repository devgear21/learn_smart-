import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://d16e-34-83-112-99.ngrok-free.app"; // Replace with your ngrok public URL

  Future<Map<String, dynamic>> processInput(
      String userInput, String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/process'));
    request.fields['user_input'] = userInput;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      throw Exception('Failed to process input');
    }
  }
}

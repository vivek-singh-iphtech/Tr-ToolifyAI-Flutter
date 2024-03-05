import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toolify_ai/constants/api.dart';

class TextGenerator {
  Future<String> GenerateResponse(String userInput) async {
    try {
      var response = await http.post(
        Uri.parse(apiConstants.apiurl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${apiConstants.API_KEY}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': userInput}
          ],
        }),
      );
 
      if(response.statusCode == 200)
      {
        var jsonResponse = json.decode(response.body);
        var assistantResponse = jsonResponse['choices'][0]['message']['content'];
        return assistantResponse;
      }
      else {
        print('Error: ${response.statusCode}');
        return 'Error';
      }
    } catch (e) {
      print('Error of catch: $e');
      return 'Error';

    }
  }
}

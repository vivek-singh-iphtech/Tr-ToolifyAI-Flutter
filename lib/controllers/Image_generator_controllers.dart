import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toolify_ai/constants/api.dart';

class ImageGenerator {
  Future<List<String>> GenerateImageResponse(String userInput) async {
    try {
      var response = await http.post(
        Uri.parse(apiConstants.ImageGenerateApIUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${apiConstants.API_KEY}',
        },
        body: jsonEncode({
          "model": "dall-e-2",
          "prompt": userInput,
          "n": 5,
          "size": "1024x1024"
        }),
      );

      if (response.statusCode == 200) {
        
        List <dynamic> jsonResponse = json.decode(response.body)['data'];
        var assistantResponse =
            List<String>.from(jsonResponse.map((image) => image['url']));
        return assistantResponse;
      } else {
        print('Error: ${response.statusCode}');
        return ['Error'];
      }
    } catch (e) {
      print('Error of catch: $e');
      return ['Error'];
    }
  }
}

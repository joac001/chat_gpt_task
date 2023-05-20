import 'package:http/http.dart' as http;
import 'dart:convert';

const endPoint = 'https://api.openai.com/v1/';
const token = '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'; //! API KEY

class GPT {
  static var client = http.Client();

  static Future<Map<String, dynamic>> sendMessage({required prompt}) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${endPoint}completions'));
    request.body = json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      "temperature": 0.4,
      "max_tokens": 2000
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();

      return json.decode(data);
    } else {
      return {
        "status": false,
        "message": "Oops, there was an error",
      };
    }
  }
}

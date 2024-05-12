import 'dart:convert';

import 'package:http/http.dart' as http;

class BartSummarize {
  final String url =
      'https://api-inference.huggingface.co/models/facebook/bart-large-cnn';
  final String accessToken = const String.fromEnvironment('ACCESS_TOKEN');

  Future<String> summarizeText(
      {required String text, int minLength = 100, int maxLength = 300}) async {
    final Map<String, dynamic> requestData = {
      "inputs": text,
      "parameters": {"max_length": maxLength, "min_length": minLength}
    };
    final String jsonData = json.encode(requestData);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData[0]['summary_text'];
    } else {
      throw Exception('Failed to summarize text: ${response.statusCode}');
    }
  }
}

import 'dart:convert';

class BartSummarize {
  final String url =
      'https://api-inference.huggingface.co/models/facebook/bart-large-cnn';
  final String accessToken = const String.fromEnvironment('ACCESS_TOKEN');

  dataToSummarize(String text) async{
    String data =  jsonEncode({
      "inputs": text,
      "parameters": {"max_length": 300, "min_length": 100}
    });
    Map config = {
      'method': 'post',
      'url': url,
      'headers': {
        'Content-Type': 'application/json',
        'Authorization': accessToken
      },
      data: data
    };
    //  try {
//     //actual api call
//     const response = await axios.request(config);
//     //The "await" keyword pauses the execution of the function until the axios request is completed
//     return (response.data[0].summary_text);
//   }
//   catch (error) {
//     console.log(error);
//   }
//
//
// }


  }







}

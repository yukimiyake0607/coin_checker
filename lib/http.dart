import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '8FD458B7-288B-4B9C-85C9-D4A58A90D9BD';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    // URLを解析してUriオブジェクトを生成
    Uri parsedUrl = Uri.parse(url);

    // HTTP GETリクエストを送信
    final response = await http.get(
      parsedUrl,
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

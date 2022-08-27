import 'package:http/http.dart' as http;

class BaseHttpClient {
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Uri _generateUri(Map<String, dynamic>? params) {
    var apiUri = Uri.parse('https://itunes.apple.com/search');

    params ??= <String, dynamic>{};

    return Uri(
      scheme: apiUri.scheme,
      host: apiUri.host,
      path: apiUri.path,
      queryParameters: params,
    );
  }

  Future<String?> getData({Map<String, dynamic>? params}) async {
    var uri = _generateUri(params);
    var res = await http.get(uri, headers: defaultHeaders);
    return res.body;
  }
}

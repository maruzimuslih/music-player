class BaseHttpClient {
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Uri generateUri(Map<String, dynamic>? params) {
    var apiUri = Uri.parse('https://itunes.apple.com/search');

    params ??= <String, dynamic>{};

    return Uri(
      scheme: apiUri.scheme,
      host: apiUri.host,
      path: apiUri.path,
      queryParameters: params,
    );
  }
}

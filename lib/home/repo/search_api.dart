import 'dart:convert';

import 'package:music_player/base_http.dart';
import 'package:music_player/home/repo/models.dart';

class SearchApi extends BaseHttpClient {
  Future<PaginatedSearchResult> getSongs({required String query}) async {
    var params = defaultParams;
    params['term'] = query;

    try {
      var res = await getData(params: params);
      var decoded = json.decode(res!);
      var songs = PaginatedSearchResult.fromJson(decoded);
      return songs;
    } catch (e) {
      rethrow;
    }
  }
}

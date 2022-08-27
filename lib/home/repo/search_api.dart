import 'dart:convert';

import 'package:music_player/base_http.dart';
import 'package:music_player/home/repo/models.dart';

class SearchApi extends BaseHttpClient {
  Future<PaginatedSearchResult> getSongs({Map<String, dynamic>? params}) async {
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

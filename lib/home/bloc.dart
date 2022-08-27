import 'package:music_player/home/repo/models.dart';
import 'package:music_player/home/repo/search_api.dart';
import 'package:music_player/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final _searchApi = serviceLocator<SearchApi>();

  final _searchResultController = BehaviorSubject<List<SearchResult>?>();

  Stream<List<SearchResult>?> get searchReultList =>
      _searchResultController.stream;

  Future<void> getSongs({String query = ''}) async {
    try {
      var res = await _searchApi.getSongs(query: query);
      var songs = res.results;
      _searchResultController.add(songs);
    } catch (e) {
      _searchResultController.addError(e);
    }
  }

  void clearSearchResultsStream() {
    _searchResultController.add(null);
  }
}

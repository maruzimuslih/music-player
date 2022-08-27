import 'package:music_player/home/repo/models.dart';
import 'package:music_player/home/repo/search_api.dart';
import 'package:music_player/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class SongBloc {
  final _searchApi = serviceLocator<SearchApi>();

  final _searchResultController = BehaviorSubject<List<SearchResult>?>();
  final _playSongController = BehaviorSubject<bool>.seeded(false);

  Stream<List<SearchResult>?> get searchReultStream =>
      _searchResultController.stream;

  Stream<bool> get playSongStream => _playSongController.stream;

  Future<void> getSongs({String query = ''}) async {
    try {
      var res = await _searchApi.getSongs(query: query);
      var songs = res.results;
      _searchResultController.add(songs);
    } catch (e) {
      _searchResultController.addError(e);
    }
  }

  void setPlaySong({bool isPlaying = false}) {
    _playSongController.add(isPlaying);
  }

  void clearPlaySongStream() {
    _playSongController.add(false);
  }

  void clearSearchResultsStream() {
    _searchResultController.add(null);
  }
}

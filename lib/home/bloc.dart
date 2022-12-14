import 'package:music_player/home/repo/models.dart';
import 'package:music_player/home/repo/search_api.dart';
import 'package:music_player/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class SongBloc {
  final _searchApi = serviceLocator<SearchApi>();

  final _searchResultController = BehaviorSubject<List<SearchResult>?>();
  final _playSongController = BehaviorSubject<int?>();
  final _songPlayingController = BehaviorSubject<bool?>();

  Stream<List<SearchResult>?> get searchReultStream =>
      _searchResultController.stream;
  Stream<int?> get playSongStream => _playSongController.stream;
  Stream<bool?> get songPlaying => _songPlayingController.stream;

  Future<void> getSongs({String query = ''}) async {
    try {
      var res = await _searchApi.getSongs(query: query);
      var songs = res.results;
      _searchResultController.add(songs);
    } catch (e) {
      _searchResultController.addError(e);
    }
  }

  void setPlaySong({required int trackId, bool isPlaying = true}) {
    setSongPlaying(isPlaying: isPlaying);
    _playSongController.add(trackId);
  }

  void setSongPlaying({required bool isPlaying}) {
    _songPlayingController.add(isPlaying);
  }

  void clearPlaySongStream() {
    _playSongController.add(null);
  }

  void clearSearchResultsStream() {
    _searchResultController.add(null);
  }
}

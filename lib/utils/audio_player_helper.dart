import 'package:audioplayers/audioplayers.dart';
export 'package:audioplayers/audioplayers.dart' show PlayerState, ReleaseMode;

class AudioPlayerHelper {
  final _audioPlayer = AudioPlayer();

  Stream<PlayerState> get onPlayerStateChanged =>
      _audioPlayer.onPlayerStateChanged;

  Future<void> playSong({required String songUrl}) async {
    await _audioPlayer.setVolume(0.7);
    await _audioPlayer.play(UrlSource(songUrl));
  }

  Future<void> pauseSong() async {
    await _audioPlayer.pause();
  }

  Future<void> resumeSong() async {
    await _audioPlayer.resume();
  }

  Future<void> setReleaseMode(ReleaseMode releaseMode) async {
    await _audioPlayer.setReleaseMode(releaseMode);
  }

  Future<void> disposePlayer() async {
    await _audioPlayer.dispose();
  }
}

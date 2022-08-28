import 'package:get_it/get_it.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/home/repo/search_api.dart';
import 'package:music_player/utils/audio_player_helper.dart';

GetIt get serviceLocator => GetIt.instance;

void initServiceLocator() {
  // REPO
  serviceLocator.registerSingleton<SearchApi>(SearchApi());
  serviceLocator.registerSingleton<SongBloc>(SongBloc());

  // UTILS
  serviceLocator.registerSingleton<AudioPlayerHelper>(AudioPlayerHelper());
}

import 'package:get_it/get_it.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/home/repo/search_api.dart';

GetIt get serviceLocator => GetIt.instance;

void initServiceLocator() {
  serviceLocator.registerSingleton<SearchApi>(SearchApi());
  serviceLocator.registerSingleton<SongBloc>(SongBloc());
}

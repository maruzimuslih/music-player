import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/home/repo/models.dart';
import 'package:music_player/home/widgets/search_field.dart';
import 'package:music_player/service_locator.dart';
import 'package:music_player/utils/audio_player_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _songBloc = serviceLocator<SongBloc>();

  @override
  void initState() {
    super.initState();
    _songBloc.clearPlaySongStream();
    _songBloc.clearSearchResultsStream();
    _songBloc.getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(),
            StreamBuilder<List<SearchResult>?>(
              stream: _songBloc.searchReultStream,
              builder: (context, snapshot) {
                var searchList = snapshot.data;
                if (searchList == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (searchList.isEmpty) {
                    return const Center(child: Text('No songs available'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (BuildContext context, int position) {
                        var song = searchList[position];
                        return _SongItem(song: song);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _MeidaControl(),
    );
  }
}

class _SongItem extends StatelessWidget {
  final SearchResult song;

  _SongItem({Key? key, required this.song}) : super(key: key);

  final _songBloc = serviceLocator<SongBloc>();
  final _audioPlayer = serviceLocator<AudioPlayerHelper>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: _songBloc.playSongStream,
      builder: (context, snapshot) {
        var songPlaying = snapshot.data;
        Widget playIndicator;
        Color? cardColor;

        if (songPlaying != null && songPlaying == song.trackId) {
          cardColor = Colors.grey.shade300;
          playIndicator = const Icon(
            Icons.music_note_sharp,
            color: Colors.green,
          );
        } else {
          playIndicator = const SizedBox.shrink();
        }

        return InkWell(
          onTap: () {
            _songBloc.setPlaySong(trackId: song.trackId!);
            _audioPlayer.playSong(songUrl: song.previewUrl!);
          },
          child: Card(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(song.artworkUrl60!),
                title: Text(
                  song.trackName!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.artistName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3.0),
                    Text(song.collectionName!)
                  ],
                ),
                trailing: playIndicator,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MeidaControl extends StatefulWidget {
  const _MeidaControl({Key? key}) : super(key: key);

  @override
  State<_MeidaControl> createState() => _MeidaControlState();
}

class _MeidaControlState extends State<_MeidaControl> {
  final _songBloc = serviceLocator<SongBloc>();
  final _audioPlayer = serviceLocator<AudioPlayerHelper>();
  late StreamSubscription<PlayerState> _audioPlayerListener;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayerListener = _audioPlayer.onPlayerStateChanged.listen((state) {
      _songBloc.setSongPlaying(isPlaying: state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _audioPlayerListener.cancel();
    _audioPlayer.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: _songBloc.playSongStream,
      builder: (context, snapshot) {
        var songPlaying = snapshot.data;
        if (songPlaying == null) {
          return const SizedBox.shrink();
        } else {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade300,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.skip_previous,
                        size: 36.0,
                      ),
                    ),
                    StreamBuilder<bool?>(
                      stream: _songBloc.songPlaying,
                      builder: (context, snapshot) {
                        var isPlaying = snapshot.data ?? false;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                _audioPlayer.pauseSong();
                              } else {
                                _audioPlayer.resumeSong();
                              }
                            },
                            icon: isPlaying
                                ? const Icon(
                                    Icons.pause,
                                    size: 36.0,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 36.0,
                                  ),
                          ),
                        );
                      },
                    ),
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.skip_next,
                        size: 36.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const LinearProgressIndicator(value: 0.5),
              ],
            ),
          );
        }
      },
    );
  }
}

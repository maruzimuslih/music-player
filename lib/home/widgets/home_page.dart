import 'package:flutter/material.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/home/repo/models.dart';
import 'package:music_player/home/widgets/search_field.dart';
import 'package:music_player/service_locator.dart';

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
                        var data = searchList[position];
                        return InkWell(
                          onTap: () {
                            _songBloc.setPlaySong(isPlaying: true);
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(data.artworkUrl60!),
                              title: Text(
                                data.trackCensoredName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.artistName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 3.0),
                                  Text(data.collectionName!)
                                ],
                              ),
                            ),
                          ),
                        );
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
      floatingActionButton: StreamBuilder<bool>(
        stream: _songBloc.playSongStream,
        builder: (context, snapshot) {
          var isPlaying = snapshot.data ?? false;
          if (!isPlaying) {
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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 36.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: IconButton(
                          onPressed: () {
                            _songBloc.setPlaySong(isPlaying: false);
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 36.0,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
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
      ),
    );
  }
}

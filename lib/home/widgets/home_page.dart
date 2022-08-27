import 'package:flutter/material.dart';
import 'package:music_player/home/bloc.dart';
import 'package:music_player/home/repo/models.dart';
import 'package:music_player/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchBloc = serviceLocator<SearchBloc>();
  final _params = {
    'term': 'skrillex',
    'entity': 'song',
  };

  @override
  void initState() {
    super.initState();
    _searchBloc.getSongs(params: _params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<SearchResult>?>(
        stream: _searchBloc.searchReultList,
        builder: (context, snapshot) {
          var searchList = snapshot.data;
          if (searchList == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (searchList.isEmpty) {
              return const Center(child: Text('No songs available'));
            }
            return ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int position) {
                var data = searchList[position];
                return Card(
                  child: ListTile(
                    leading: Image.network(data.artworkUrl60!),
                    title: Text(
                      data.trackCensoredName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.artistName!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3.0),
                        Text(data.collectionName!)
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
